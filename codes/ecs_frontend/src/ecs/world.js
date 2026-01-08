// src/ecs/world.js
import { Entity } from './entity.js';
import { ComponentManager } from './component_manager.js';
import { SystemManager } from './system_manager.js';

export class World {
  constructor() {
    this.entities = []; // List of entity IDs
    this.nextEntityId = 0;
    this.componentManager = new ComponentManager();
    this.systemManager = new SystemManager(this);
  }

  createEntity() {
    const id = this.nextEntityId++;
    this.entities.push(id);
    return id; // Return raw ID
  }

  addComponent(entityId, componentType, data) {
    this.componentManager.add(entityId, componentType, data);
  }

  getComponent(entityId, componentType) {
    return this.componentManager.get(entityId, componentType);
  }

  removeComponent(entityId, componentType) {
    this.componentManager.remove(entityId, componentType);
  }

  registerSystem(system) {
    this.systemManager.register(system);
  }

  update(delta) {
    this.systemManager.update(delta);
  }
}
