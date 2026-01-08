// src/ecs/system_manager.js

export class SystemManager {
  constructor(world) {
    this.world = world;
    this.systems = [];
  }

  register(system) {
    this.systems.push(system);
  }

  update(delta) {
    for (const system of this.systems) {
      if (system.update) {
        system.update(delta, this.world);
      }
    }
  }
}
