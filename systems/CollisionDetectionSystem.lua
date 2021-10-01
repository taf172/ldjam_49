local secsi = require 'secsi'

local function getNormal(x1, y1, x2, y2)
    local dx = x2 - x1
    local dy = y2 - y1
    return -dy, dx
end

local function getNormals(points)
    local normals = {}
    local n = #points
    for i=1, n - 2, 2 do
        local x1, y1 = points[i], points[i + 1]
        local x2, y2 = points[i + 2], points[i + 3]
        normals[i], normals[i + 1] = getNormal(x1, y1, x2, y2)
    end
    normals[n-1], normals[n] = getNormal(points[n-1], points[n], points[1], points[2])
    return normals
end

local function getProjection(points, axis)
    local min = points[1] * axis[1] + points[2] * axis[2]
    local max = min
    for i = 3, #points, 2 do
        local p = points[i] * axis[1] + points[i + 1] * axis[2]
        if p < min then
            min = p
        elseif p > max then
            max = p
        end
    end
    return min, max
end

local function isOverlapping(min1, max1, min2, max2)
    return (min1 > min2 and min1 < max2)
    or (max1 < max2 and max1 > min2)
    or (min2 > min1 and min2 < max1)
    or (max2 < max1 and max2 > min1)
end

local function isColliding(points1, norms1, points2, norms2)
    for i = 1, #norms1, 2 do
        local axis = {norms1[i], norms1[i+1]}
        local min1, max1 = getProjection(points1, axis)
        local min2, max2 = getProjection(points2, axis)
        if not isOverlapping(min1, max1, min2, max2) then return false end
    end
    for i = 1, #norms2, 2 do
        local axis = {norms2[i], norms2[i+1]}
        local min1, max1 = getProjection(points1, axis)
        local min2, max2 = getProjection(points2, axis)
        if not isOverlapping(min1, max1, min2, max2) then return false end
    end
    return true
end

local CollisionDectionSystem = secsi.system{'x', 'y', 'vertices', 'getTransform'}

function CollisionDectionSystem.update(e)
    local points1 = e:getTransform()
    local norms1 = getNormals(points1)

    e.colliding = false
    for i, poly in pairs(secsi.get{'x', 'y', 'vertices', 'getTransform'}) do
        local points2 = poly:getTransform()
        local norms2 = getNormals(points2)

        if isColliding(points1, norms1, points2, norms2) then
            e.colliding = true
        end
    end

end
