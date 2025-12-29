use std::mem;

trait Speak {
    fn say(&self);
}

struct Dog;
impl Speak for Dog {
    fn say(&self) {
        println!("Woof!");
    }
}

struct Cat;
impl Speak for Cat {
    fn say(&self) {
        println!("Meow!");
    }
}

fn main() {
    println!("--- Static Dispatch (Monomorphization) ---");
    // These calls are resolved at compile time to specific functions.
    static_dispatch(Dog);
    static_dispatch(Cat);

    println!("\n--- Dynamic Dispatch (Internals) ---");
    let dog = Dog;
    let cat = Cat;

    // Coercing to trait objects creates "fat pointers"
    let dog_dyn: &dyn Speak = &dog;
    let cat_dyn: &dyn Speak = &cat;

    dynamic_dispatch(dog_dyn);
    dynamic_dispatch(cat_dyn);

    println!("\n--- Internals Inspection ---");
    // Standard reference size (usize) - 8 bytes on 64-bit
    println!("Size of &Dog (thin pointer): {} bytes", mem::size_of::<&Dog>());

    // Trait object reference size (2 * usize) - 16 bytes on 64-bit
    // This confirms it holds (data_ptr, vtable_ptr)
    println!("Size of &dyn Speak (fat pointer): {} bytes", mem::size_of::<&dyn Speak>());

    // We can even verify the raw parts (unsafe)
    unsafe {
        let (data_ptr, vtable_ptr): (usize, usize) = mem::transmute(dog_dyn);
        println!("Fat Pointer Layout:");
        println!("  Data address:   0x{:x}", data_ptr);
        println!("  Vtable address: 0x{:x}", vtable_ptr);
    }
}

// Generates specific versions for T=Dog and T=Cat
fn static_dispatch<T: Speak>(item: T) {
    item.say();
}

// Uses the vtable to find the method at runtime
fn dynamic_dispatch(item: &dyn Speak) {
    item.say();
}
