--!strict

local CollectionService = game:GetService("CollectionService")

local Janitor = require(script.Parent.Janitor)

--[[
	Creates a TaggedObject with the given tag name.
	
	The function will be called for every instance with the tag and will
	be passed the instance and a janitor which would be destroyed once
	the tag is removed or the instance is destroyed.
]]
local function TaggedObject(tagName: string, fn: (instance: Instance, janitor: Janitor.Janitor) -> ())
	local janitors = {} :: { [Instance]: Janitor.Janitor }

	local function instanceAdded(instance: Instance)
		local janitor = Janitor.new()
		janitors[instance] = janitor

		fn(instance, janitor)
	end

	local function instanceRemoved(instance: Instance)
		local janitor = janitors[instance]
		if not janitor then
			return warn(("Tag '%s' was removed from instance with no associated janitor."):format(tagName))
		end

		janitor:Destroy()
		janitors[instance] = nil
	end

	CollectionService:GetInstanceAddedSignal(tagName):Connect(instanceAdded)
	CollectionService:GetInstanceRemovedSignal(tagName):Connect(instanceRemoved)
	for _, instance in CollectionService:GetTagged(tagName) do
		instanceAdded(instance)
	end
end

return TaggedObject
