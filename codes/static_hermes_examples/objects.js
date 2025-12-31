// 2. Objects and properties
var person = {
  firstName: "John",
  lastName: "Doe",
  age: 30,
  isEmployed: true,
  address: {
    city: "New York",
    zip: "10001"
  }
};

print("Name: " + person.firstName + " " + person.lastName);
print("Age: " + person.age);
print("City: " + person.address.city);

person.age += 1;
print("Next year age: " + person.age);
