(module
  (import "env" "putchar" (func $putchar (param i32)))

  ;; Define a function type for 'speak': () -> i32
  (type $SpeakFunc (func (param (ref null any)) (result i32)))

  ;; VTable struct containing the speak function
  (type $VTable (struct (field (ref $SpeakFunc))))

  ;; Base Object struct (header) containing VTable
  ;; In a real compiler, we might layout objects with a vtable pointer at offset 0.
  (type $Object (struct (field (ref $VTable))))

  ;; Dog and Cat are just Objects for this simple example,
  ;; but could have more fields.
  ;; We can rely on structural typing or simply use the same layout.
  ;; Let's use the same layout for simplicity, as Wasm GC structs are nominal.
  ;; To have subtyping, we'd need type hierarchies (sub).
  ;; Let's use a common supertype $Animal.

  (type $Animal (sub (struct (field (ref $VTable)))))
  (type $Dog (sub $Animal (struct (field (ref $VTable)))))
  (type $Cat (sub $Animal (struct (field (ref $VTable)))))

  ;; Dog.speak implementation
  (func $dog_speak (param $self (ref null any)) (result i32)
    (i32.const 68) ;; 'D'
  )

  ;; Cat.speak implementation
  (func $cat_speak (param $self (ref null any)) (result i32)
    (i32.const 67) ;; 'C'
  )

  (func $makeSound (param $animal (ref $Animal))
    (local $vtable (ref $VTable))
    (local $func (ref $SpeakFunc))

    ;; Get vtable
    (local.set $vtable (struct.get $Animal 0 (local.get $animal)))
    ;; Get function from vtable
    (local.set $func (struct.get $VTable 0 (local.get $vtable)))

    ;; Call function(animal)
    (call $putchar
      (call_ref $SpeakFunc
        (local.get $animal)
        (local.get $func)
      )
    )
  )

  (func $main
    (local $dogVTable (ref $VTable))
    (local $catVTable (ref $VTable))

    ;; Init VTables
    (local.set $dogVTable (struct.new $VTable (ref.func $dog_speak)))
    (local.set $catVTable (struct.new $VTable (ref.func $cat_speak)))

    ;; makeSound(new Dog())
    (call $makeSound
      (struct.new $Dog (local.get $dogVTable))
    )

    ;; makeSound(new Cat())
    (call $makeSound
      (struct.new $Cat (local.get $catVTable))
    )
  )

  (elem declare func $dog_speak $cat_speak)
  (start $main)
)
