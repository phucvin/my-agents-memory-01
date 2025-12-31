const username$moonbit_examples$cmd$traits$$_main$46$dog$47$7 = { name: "Buddy" };
const username$moonbit_examples$cmd$traits$$_main$46$cat$47$8 = { name: "Whiskers" };
function moonbitlang$core$builtin$$println$0$(input) {
  console.log(input);
}
function username$moonbit_examples$cmd$traits$$introduce$1$(animal) {
  moonbitlang$core$builtin$$println$0$(`Woof! I am ${animal.name}`);
}
function username$moonbit_examples$cmd$traits$$introduce$2$(animal) {
  moonbitlang$core$builtin$$println$0$(`Meow! I am ${animal.name}`);
}
(() => {
  username$moonbit_examples$cmd$traits$$introduce$1$(username$moonbit_examples$cmd$traits$$_main$46$dog$47$7);
  username$moonbit_examples$cmd$traits$$introduce$2$(username$moonbit_examples$cmd$traits$$_main$46$cat$47$8);
})();
