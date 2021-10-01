local secsi = require 'secsi'

local Polygon = secsi.entity{}

function Polygon:init(x, y, vertices)
    self.rotation = 0
    self.vertices = vertices
    self.x = x
    self.y = y

    -- Find centroid
    local n = #vertices
    local signedArea = 0
    local centroid = {0, 0}

    for i=1, n, 2 do

        local x0 = vertices[i]
        local y0 = vertices[i + 1]
        local x1
        local y1
        if i == n - 1 then
            x1 = vertices[1]
            y1 = vertices[2]
        else
            x1 = vertices[i + 2]
            y1 = vertices[i + 3]
        end

        local A = (x0 * y1) - (x1 * y0)
        signedArea = signedArea + A

        centroid[1] = centroid[1] + (x0 + x1)*A
        centroid[2] = centroid[2] + (y0 + y1)*A
    end

    signedArea = signedArea*0.5
    centroid[1] = centroid[1] / (6 * signedArea)
    centroid[2] = centroid[2] / (6 * signedArea)

    self.centroid = centroid

end

function Polygon:getTransform()
    local translated = {}
    local sin = math.sin(self.rotation)
    local cos = math.cos(self.rotation)
    for i=1, #self.vertices, 2 do
        local x = self.vertices[i] - self.centroid[1]
        local y = self.vertices[i + 1] - self.centroid[2]

        local dx = x*cos - y*sin + self.x
        local dy = x*sin + y*cos + self.y

        translated[i] = dx
        translated[i + 1] = dy
    end
    return translated
end

return Polygon