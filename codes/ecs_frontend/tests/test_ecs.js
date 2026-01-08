// tests/test_ecs.js
import { World } from '../src/ecs/world.js';
import { strict as assert } from 'assert';

console.log('Running ECS Tests...');

// Test 1: Entity Creation
{
  const world = new World();
  const e1 = world.createEntity();
  const e2 = world.createEntity();
  assert.notEqual(e1, e2);
  console.log('✓ Entity Creation Passed');
}

// Test 2: Component Addition/Retrieval
{
  const world = new World();
  const e = world.createEntity();
  const Pos = 'Position';
  world.addComponent(e, Pos, { x: 10, y: 20 });
  const data = world.getComponent(e, Pos);
  assert.deepEqual(data, { x: 10, y: 20 });
  console.log('✓ Component Storage Passed');
}

// Test 3: System Query
{
  const world = new World();
  const e1 = world.createEntity();
  const e2 = world.createEntity();

  const TypeA = 'A';
  const TypeB = 'B';

  world.addComponent(e1, TypeA, {});
  world.addComponent(e1, TypeB, {});
  world.addComponent(e2, TypeA, {});

  const both = world.componentManager.query([TypeA, TypeB]);
  assert.equal(both.length, 1);
  assert.equal(both[0], e1);

  const justA = world.componentManager.query([TypeA]);
  assert.equal(justA.length, 2);

  console.log('✓ System Query Passed');
}

console.log('All tests passed!');
