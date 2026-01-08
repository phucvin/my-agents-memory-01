// src/ecs/component_manager.js

// Using a simplistic approach: Map<ComponentType, Map<EntityId, Data>>
// For true Data-Oriented Design, this should be TypedArrays.
// I will implement a hybrid approach where "ComponentType" defines the storage strategy.

export class ComponentManager {
  constructor() {
    this.storages = new Map();
  }

  getStorage(componentType) {
    if (!this.storages.has(componentType)) {
      this.storages.set(componentType, new Map());
    }
    return this.storages.get(componentType);
  }

  add(entityId, componentType, data) {
    const storage = this.getStorage(componentType);
    storage.set(entityId, data);
  }

  get(entityId, componentType) {
    const storage = this.getStorage(componentType);
    return storage ? storage.get(entityId) : undefined;
  }

  remove(entityId, componentType) {
    const storage = this.getStorage(componentType);
    if (storage) {
      storage.delete(entityId);
    }
  }

  // Returns an iterator of entities that have all specified component types
  query(componentTypes) {
    // Naive implementation
    // Find the smallest storage to iterate
    if (componentTypes.length === 0) return [];

    // Sort by size (optimization)
    const storages = componentTypes.map(type => this.getStorage(type));

    // If any storage is empty, result is empty
    if (storages.some(s => s.size === 0)) return [];

    // Iterate the first one and check others
    const candidates = storages[0].keys();
    const result = [];

    for (const entityId of candidates) {
      let match = true;
      for (let i = 1; i < storages.length; i++) {
        if (!storages[i].has(entityId)) {
          match = false;
          break;
        }
      }
      if (match) {
        result.push(entityId);
      }
    }
    return result;
  }
}
