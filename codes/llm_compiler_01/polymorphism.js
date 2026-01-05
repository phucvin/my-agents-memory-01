// Polymorphism
class Dog { speak() { return 68; } } // 'D'
class Cat { speak() { return 67; } } // 'C'

function makeSound(animal) {
  putchar(animal.speak());
}

makeSound(new Dog());
makeSound(new Cat());
