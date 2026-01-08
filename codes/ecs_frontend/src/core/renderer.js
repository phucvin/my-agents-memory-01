// src/core/renderer.js

// This is the bridge between ECS and DOM.
// We treat the DOM as a "View" of the ECS state.

// Component Types
export const NodeComponent = 'Node'; // Stores the DOM node
export const TagComponent = 'Tag'; // Stores the tag name (string)
export const PropsComponent = 'Props'; // Stores properties (object)
export const ChildrenComponent = 'Children'; // Stores child Entity IDs (array)
export const TextComponent = 'Text'; // Stores text content

export class DomSystem {
  constructor() {
    this.rootContainer = null;
  }

  mount(entityId, container, world) {
    this.rootContainer = container;
    // Ensure the root entity is processed?
    // Usually we just run update.
  }

  update(delta, world) {
    // 1. Create DOM nodes for entities that have Tag/Text but no Node
    const entitiesToCreate = world.componentManager.query([TagComponent]);
    for (const entityId of entitiesToCreate) {
      if (!world.getComponent(entityId, NodeComponent)) {
        const tag = world.getComponent(entityId, TagComponent);
        const element = document.createElement(tag);
        world.addComponent(entityId, NodeComponent, element);

        // Handle initial props
        const props = world.getComponent(entityId, PropsComponent);
        if (props) this.applyProps(element, props);
      }
    }

    const textEntities = world.componentManager.query([TextComponent]);
    for (const entityId of textEntities) {
      if (!world.getComponent(entityId, NodeComponent)) {
        const text = world.getComponent(entityId, TextComponent);
        const node = document.createTextNode(text);
        world.addComponent(entityId, NodeComponent, node);
      } else {
         // Update text if changed
         const node = world.getComponent(entityId, NodeComponent);
         const text = world.getComponent(entityId, TextComponent);
         if (node.textContent !== text) {
             node.textContent = text;
         }
      }
    }

    // 2. Update hierarchy
    // Iterate entities with Children and ensure they are appended to the parent's Node
    const entitiesWithChildren = world.componentManager.query([NodeComponent, ChildrenComponent]);
    for (const entityId of entitiesWithChildren) {
      const parentNode = world.getComponent(entityId, NodeComponent);
      const childrenIds = world.getComponent(entityId, ChildrenComponent);

      // Simple reconciliation: clear and append (naive)
      // Optimization: Diffing.
      // For this prototype, we'll check if the DOM matches the children list order.

      let domChild = parentNode.firstChild;
      for (const childId of childrenIds) {
        const childNode = world.getComponent(childId, NodeComponent);
        if (childNode) {
            if (domChild !== childNode) {
                parentNode.insertBefore(childNode, domChild);
            } else {
                domChild = domChild.nextSibling;
            }
        }
      }

      // Remove remaining nodes
      while (domChild) {
        const next = domChild.nextSibling;
        parentNode.removeChild(domChild);
        domChild = next;
      }
    }

    // 3. Update Props
    // (Ideally we only do this if props changed. We can add a 'Dirty' component)
    const entitiesWithProps = world.componentManager.query([NodeComponent, PropsComponent]);
    for (const entityId of entitiesWithProps) {
        const node = world.getComponent(entityId, NodeComponent);
        const props = world.getComponent(entityId, PropsComponent);
        this.applyProps(node, props);
    }
  }

  applyProps(element, props) {
    for (const key in props) {
      if (key.startsWith('on')) {
        const eventName = key.substring(2).toLowerCase();
        // Naive event binding - remove old listener?
        // Ideally we store the listener to remove it later.
        // For prototype, simply setting onclick works if it's a property,
        // but for addEventListener we need to be careful.
        // Let's use properties for standard events.
        element[key.toLowerCase()] = props[key];
      } else {
        element.setAttribute(key, props[key]);
      }
    }
  }
}
