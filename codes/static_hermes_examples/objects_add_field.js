var point = {
  x: 10,
  y: 20
};

print("Point: " + point.x + ", " + point.y);

// Add a new field
point.z = 30;
print("Point with z: " + point.x + ", " + point.y + ", " + point.z);

// Modify the new field
point.z += 5;
print("Updated z: " + point.z);
