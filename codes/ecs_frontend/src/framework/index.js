// src/framework/index.js
import { World } from '../ecs/world.js';
import {
  DomSystem, TagComponent, PropsComponent, ChildrenComponent, TextComponent, NodeComponent
} from '../core/renderer.js';

// Global world instance
export const world = new World();
const domSystem = new DomSystem();
world.registerSystem(domSystem);

// Main render loop
function tick() {
  world.update();
  requestAnimationFrame(tick);
}

export function render(element, container) {
  // Mount the root element
  // 'element' here is an Entity ID returned by createElement

  // Create a root entity that represents the container?
  // Or just append the element to container?
  // Let's make the container a special entity.
  const rootId = world.createEntity();
  world.addComponent(rootId, NodeComponent, container);
  world.addComponent(rootId, ChildrenComponent, [element]);

  // Start loop
  if (typeof requestAnimationFrame !== 'undefined') {
    requestAnimationFrame(tick);
  }
}

// React-like createElement (hyperscript)
export function createElement(tag, props, ...children) {
  const entityId = world.createEntity();

  if (typeof tag === 'function') {
    // Functional component
    return tag({ ...props, children });
  }

  if (typeof tag === 'string') {
    world.addComponent(entityId, TagComponent, tag);
  }

  if (props) {
    world.addComponent(entityId, PropsComponent, props);
  }

  const flatChildren = children.flat().map(child => {
    if (typeof child === 'string' || typeof child === 'number') {
      const textId = world.createEntity();
      world.addComponent(textId, TextComponent, String(child));
      return textId;
    }
    return child; // Assume it's an entity ID
  });

  world.addComponent(entityId, ChildrenComponent, flatChildren);

  return entityId;
}

// Signals (Reactivity)
// When a signal changes, it should update the component that uses it.
// In ECS, this is tricky because "Component" logic usually runs once to create entities.
// We need a way to re-run the logic or update the entity data.

// For this prototype, we'll implementing a simple signal that
// updates the TextComponent or PropsComponent of bound entities.

let currentListener = null;

export function createSignal(initialValue) {
  let value = initialValue;
  const subscribers = new Set(); // Set of functions to call

  const read = () => {
    if (currentListener) {
      subscribers.add(currentListener);
    }
    return value;
  };

  const write = (newValue) => {
    if (typeof newValue === 'function') {
        value = newValue(value);
    } else {
        value = newValue;
    }
    subscribers.forEach(fn => fn(value));
  };

  return [read, write];
}

// Effect hook to bind signals to ECS updates
export function createEffect(fn) {
    currentListener = fn;
    fn();
    currentListener = null;
}

// Helper to update text dynamically
// Usage: <div>{() => count()}</div>
export function dynamicText(signalFn) {
    const entityId = world.createEntity();
    world.addComponent(entityId, TextComponent, "");

    createEffect(() => {
        const val = signalFn();
        world.addComponent(entityId, TextComponent, String(val));
    });

    return entityId;
}
