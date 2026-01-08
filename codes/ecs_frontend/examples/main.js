// examples/main.js
import { render, createElement, createSignal, dynamicText } from '../src/index.js';

function Counter() {
  const [count, setCount] = createSignal(0);

  return createElement('div', { style: 'padding: 20px; font-family: sans-serif;' },
    createElement('h1', null, 'ECS Frontend Framework'),
    createElement('p', null, 'Count is: ', dynamicText(() => count())),
    createElement('button', {
      onclick: () => setCount(c => c + 1),
      style: 'padding: 10px; background: #007bff; color: white; border: none; border-radius: 5px; cursor: pointer;'
    }, 'Increment')
  );
}

const app = document.getElementById('app');
if (app) {
    render(Counter(), app);
}
