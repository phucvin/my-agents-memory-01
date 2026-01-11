function Shape$Circle(param0) {
  this._0 = param0;
}
Shape$Circle.prototype.$tag = 0;
function Shape$Rectangle(param0, param1) {
  this._0 = param0;
  this._1 = param1;
}
Shape$Rectangle.prototype.$tag = 1;
function Result$Err$0$(param0) {
  this._0 = param0;
}
Result$Err$0$.prototype.$tag = 0;
function Result$Ok$0$(param0) {
  this._0 = param0;
}
Result$Ok$0$.prototype.$tag = 1;
const Error$moonbitlang$47$core$47$builtin$46$CreatingViewError$46$IndexOutOfBounds = { $tag: 1 };
const Error$moonbitlang$47$core$47$builtin$46$CreatingViewError$46$InvalidIndex = { $tag: 0 };
class $PanicError extends Error {}
function $panic() {
  throw new $PanicError();
}
const moonbitlang$core$double$internal$ryu$$ryu_to_string = (number) => number.toString();
const $$$64$moonbitlang$47$core$47$builtin$46$StringBuilder$36$as$36$64$moonbitlang$47$core$47$builtin$46$Logger = { method_0: moonbitlang$core$builtin$$Logger$write_string$0$, method_1: moonbitlang$core$builtin$$Logger$write_substring$1$, method_2: moonbitlang$core$builtin$$Logger$write_view$0$, method_3: moonbitlang$core$builtin$$Logger$write_char$0$ };
const username$moonbit_examples$cmd$enums$$_main$46$c$47$69 = new Shape$Circle(5);
const username$moonbit_examples$cmd$enums$$_main$46$r$47$70 = new Shape$Rectangle(4, 6);
function moonbitlang$core$builtin$$StringBuilder$new$46$inner(size_hint) {
  return { val: "" };
}
function moonbitlang$core$builtin$$Logger$write_char$0$(self, ch) {
  const _bind = self;
  _bind.val = `${_bind.val}${String.fromCodePoint(ch)}`;
}
function moonbitlang$core$builtin$$Logger$write_string$0$(self, str) {
  const _bind = self;
  _bind.val = `${_bind.val}${str}`;
}
function moonbitlang$core$string$$String$sub$46$inner(self, start, end) {
  const len = self.length;
  let end$2;
  if (end === undefined) {
    end$2 = len;
  } else {
    const _Some = end;
    const _end = _Some;
    end$2 = _end < 0 ? len + _end | 0 : _end;
  }
  const start$2 = start < 0 ? len + start | 0 : start;
  if (start$2 >= 0 && (start$2 <= end$2 && end$2 <= len)) {
    let _tmp;
    if (start$2 < len) {
      const _p = self.charCodeAt(start$2);
      _tmp = 56320 <= _p && _p <= 57343;
    } else {
      _tmp = false;
    }
    if (_tmp) {
      return new Result$Err$0$(Error$moonbitlang$47$core$47$builtin$46$CreatingViewError$46$InvalidIndex);
    }
    let _tmp$2;
    if (end$2 < len) {
      const _p = self.charCodeAt(end$2);
      _tmp$2 = 56320 <= _p && _p <= 57343;
    } else {
      _tmp$2 = false;
    }
    if (_tmp$2) {
      return new Result$Err$0$(Error$moonbitlang$47$core$47$builtin$46$CreatingViewError$46$InvalidIndex);
    }
    return new Result$Ok$0$({ str: self, start: start$2, end: end$2 });
  } else {
    return new Result$Err$0$(Error$moonbitlang$47$core$47$builtin$46$CreatingViewError$46$IndexOutOfBounds);
  }
}
function moonbitlang$core$builtin$$Logger$write_substring$1$(self, value, start, len) {
  let _tmp;
  let _try_err;
  _L: {
    _L$2: {
      const _bind = moonbitlang$core$string$$String$sub$46$inner(value, start, start + len | 0);
      if (_bind.$tag === 1) {
        const _ok = _bind;
        _tmp = _ok._0;
      } else {
        const _err = _bind;
        const _tmp$2 = _err._0;
        _try_err = _tmp$2;
        break _L$2;
      }
      break _L;
    }
    _tmp = $panic();
  }
  moonbitlang$core$builtin$$Logger$write_view$0$(self, _tmp);
}
function moonbitlang$core$builtin$$Show$to_string$2$(self) {
  const logger = moonbitlang$core$builtin$$StringBuilder$new$46$inner(0);
  moonbitlang$core$builtin$$Show$output$3$(self, { self: logger, method_table: $$$64$moonbitlang$47$core$47$builtin$46$StringBuilder$36$as$36$64$moonbitlang$47$core$47$builtin$46$Logger });
  return logger.val;
}
function moonbitlang$core$builtin$$Show$to_string$4$(self) {
  return self.str.substring(self.start, self.end);
}
function moonbitlang$core$builtin$$Logger$write_view$0$(self, str) {
  const _bind = self;
  _bind.val = `${_bind.val}${moonbitlang$core$builtin$$Show$to_string$4$(str)}`;
}
function moonbitlang$core$builtin$$println$5$(input) {
  console.log(input);
}
function moonbitlang$core$double$$Double$to_string(self) {
  return moonbitlang$core$double$internal$ryu$$ryu_to_string(self);
}
function moonbitlang$core$builtin$$Show$output$3$(self, logger) {
  logger.method_table.method_0(logger.self, moonbitlang$core$double$$Double$to_string(self));
}
function username$moonbit_examples$cmd$enums$$area(shape) {
  if (shape.$tag === 0) {
    const _Circle = shape;
    const _r = _Circle._0;
    return 3.14159 * _r * _r;
  } else {
    const _Rectangle = shape;
    const _w = _Rectangle._0;
    const _h = _Rectangle._1;
    return _w * _h;
  }
}
(() => {
  moonbitlang$core$builtin$$println$5$(`Area of circle: ${moonbitlang$core$builtin$$Show$to_string$2$(username$moonbit_examples$cmd$enums$$area(username$moonbit_examples$cmd$enums$$_main$46$c$47$69))}`);
  moonbitlang$core$builtin$$println$5$(`Area of rectangle: ${moonbitlang$core$builtin$$Show$to_string$2$(username$moonbit_examples$cmd$enums$$area(username$moonbit_examples$cmd$enums$$_main$46$r$47$70))}`);
})();
