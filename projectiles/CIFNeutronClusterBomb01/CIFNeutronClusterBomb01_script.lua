-------------------------------------------------------------------------------
--
--  File     :  /projectiles/CIFNeutronClusterBomb01/CIFNeutronClusterBomb01.lua
--  Author(s):  Gordon Duclos
--
--  Summary  :  Cybran Neutron Cluster bomb
--
--  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
-------------------------------------------------------------------------------

local CNeutronClusterBombProjectile = import('/lua/cybranprojectiles.lua').CNeutronClusterBombProjectile

CIFNeutronClusterBomb01 = Class(CNeutronClusterBombProjectile) {
    OnImpact = function(self, targetType, targetEntity)
        local pos = self:GetPosition()
        local radius = self.DamageData.DamageRadius
        local FriendlyFire = self.DamageData.DamageFriendly and radius ~=0
        
        DamageArea( self, pos, radius, 1, 'Force', FriendlyFire )
        DamageArea( self, pos, radius, 1, 'Force', FriendlyFire )

        self.DamageData.DamageAmount = self.DamageData.DamageAmount - 2
        
        if targetType ~= 'Shield' and targetType ~= 'Water' and targetType ~= 'Air' and targetType ~= 'UnitAir' and targetType ~= 'Projectile' then
            local RandomFloat = import('/lua/utilities.lua').GetRandomFloat
            local rotation = RandomFloat(0,2*math.pi)
            local size = radius-1.5 + RandomFloat(0,1.0)
            local army = self.Army

            CreateDecal(pos, rotation, 'scorch_001_albedo', '', 'Albedo', size, size, 150, 30, army)
        end
        
        CNeutronClusterBombProjectile.OnImpact(self, targetType, targetEntity)
    end,
}

TypeClass = CIFNeutronClusterBomb01
