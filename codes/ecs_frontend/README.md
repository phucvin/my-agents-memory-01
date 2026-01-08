# ECS Frontend Framework

A prototype web frontend framework that uses an Entity Component System (ECS) architecture internally while exposing a React/SolidJS-like API.

## Features

- **ECS Architecture**: Entities, Components, and Systems manage the UI state and rendering.
- **Data-Oriented Design**: Components are stored in contiguous memory blocks (conceptually, implemented via Maps/Arrays for this JS prototype).
- **Reactive Signals**: Fine-grained reactivity similar to SolidJS.
- **Hyperscript API**: `createElement` function for building UI.

## Structure

- `src/ecs`: Core ECS implementation (World, Entity, ComponentManager, SystemManager).
- `src/core`: Renderer (DomSystem) and base component definitions.
- `src/framework`: High-level API (createElement, signals).

## Usage

### 1. Build the Project

We use a custom compiler script (which essentially bundles/copies files for distribution).

```bash
node tools/compiler.js
```

This will create a `dist/` directory containing the source, examples, and an `index.html`.

### 2. Run Tests

To run the internal ECS tests:

```bash
node tests/test_ecs.js
```

### 3. Run the Example

After building, you can serve the `dist` folder using any static file server. For example:

```bash
# Using python
cd dist
python3 -m http.server
```

Then open `http://localhost:8000` in your browser.

## Example Code

```javascript
import { render, createElement, createSignal, dynamicText } from '../src/index.js';

function Counter() {
  const [count, setCount] = createSignal(0);

  return createElement('div', null,
    createElement('h1', null, 'Hello ECS'),
    createElement('p', null, 'Count: ', dynamicText(() => count())),
    createElement('button', { onclick: () => setCount(c => c + 1) }, 'Increment')
  );
}

render(Counter(), document.getElementById('app'));
```
