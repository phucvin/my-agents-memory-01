
const supportsStreaming = () => {
    try {
        if (typeof WebAssembly === 'undefined') return false;
        if (typeof WebAssembly.instantiateStreaming !== 'function') return false;

        return !/^((?!chrome|android).)*safari/i.test(navigator.userAgent) ||
               parseInt(navigator.userAgent.match(/version\/(\d+)/i)?.[1] || 0) >= 15;
    } catch { return false; }
};

const run = async () => {
    const imports = {
        env: {
            // C++ calls this function to tell JS "I wrote commands, please execute them"
            webcc_js_flush: (ptr, size) => flush(ptr, size),
            // C++ runtime
            __cxa_atexit: () => 0,
            __cxa_thread_atexit: () => 0,
            __cxa_finalize: () => {}
,
            webcc_dom_get_body: () => {
                if(!elements[0]) elements[0] = document.body; return 0;
            }
,
            webcc_canvas_create_canvas: (dom_id_ptr, dom_id_len, width, height) => {
                const dom_id = decoder.decode(new Uint8Array(memory.buffer, dom_id_ptr, dom_id_len));
                const handle = (window.webcc_next_id = (window.webcc_next_id || 0) + 1); const c = document.createElement('canvas'); c.id = dom_id; c.width = width; c.height = height; elements[dom_id] = c; elements[handle] = c; return handle;
            }
,
            webcc_canvas_get_context_2d: (canvas_handle) => {
                const handle = (window.webcc_next_id = (window.webcc_next_id || 0) + 1); const c = elements[canvas_handle]; if(!c) { console.warn('get_context_2d: unknown canvas', canvas_handle); return -1; } contexts[handle] = c.getContext('2d'); return handle;
            }

        }
    };

    let mod;
    if (supportsStreaming()) {
        mod = await WebAssembly.instantiateStreaming(fetch('app.wasm'), imports);
    } else {
        const response = await fetch('app.wasm');
        const bytes = await response.arrayBuffer();
        mod = await WebAssembly.instantiate(bytes, imports);
    }
    const { memory, main, __indirect_function_table: table, webcc_event_buffer_ptr, webcc_event_offset_ptr, webcc_event_buffer_capacity, webcc_scratch_buffer_ptr } = mod.instance.exports;

    const event_buffer_ptr_val = webcc_event_buffer_ptr();
    const event_offset_ptr_val = webcc_event_offset_ptr();
    const scratch_buffer_ptr_val = webcc_scratch_buffer_ptr();
    let event_offset_view = new Uint32Array(memory.buffer, event_offset_ptr_val, 1);
    let event_u8 = new Uint8Array(memory.buffer, event_buffer_ptr_val);
    let event_i32 = new Int32Array(memory.buffer, event_buffer_ptr_val);
    let event_f32 = new Float32Array(memory.buffer, event_buffer_ptr_val);
    const text_encoder = new TextEncoder();
    const EVENT_BUFFER_SIZE = webcc_event_buffer_capacity();

    function push_event_dom_CLICK(handle) {
        if (event_u8.buffer !== memory.buffer) {
            event_u8 = new Uint8Array(memory.buffer, event_buffer_ptr_val);
            event_i32 = new Int32Array(memory.buffer, event_buffer_ptr_val);
            event_f32 = new Float32Array(memory.buffer, event_buffer_ptr_val);
            event_offset_view = new Uint32Array(memory.buffer, event_offset_ptr_val, 1);
        }
        if (event_offset_view[0] + 4096 > EVENT_BUFFER_SIZE) { console.warn('WebCC: Event buffer full, dropping event CLICK'); return; }
        let pos = event_offset_view[0];
        const start_pos = pos;
        event_u8[pos] = 1;
        pos += 4; // Skip header (opcode + pad + size)
        event_i32[pos >> 2] = handle; pos += 4;
        const len = pos - start_pos;
        event_u8[start_pos + 2] = len & 0xFF;
        event_u8[start_pos + 3] = (len >> 8) & 0xFF;
        event_offset_view[0] = pos;
    }
    function push_event_dom_INPUT(handle, value) {
        if (event_u8.buffer !== memory.buffer) {
            event_u8 = new Uint8Array(memory.buffer, event_buffer_ptr_val);
            event_i32 = new Int32Array(memory.buffer, event_buffer_ptr_val);
            event_f32 = new Float32Array(memory.buffer, event_buffer_ptr_val);
            event_offset_view = new Uint32Array(memory.buffer, event_offset_ptr_val, 1);
        }
        if (event_offset_view[0] + 4096 > EVENT_BUFFER_SIZE) { console.warn('WebCC: Event buffer full, dropping event INPUT'); return; }
        let pos = event_offset_view[0];
        const start_pos = pos;
        event_u8[pos] = 2;
        pos += 4; // Skip header (opcode + pad + size)
        event_i32[pos >> 2] = handle; pos += 4;
        const encoded_1 = text_encoder.encode(value);
        const len_1 = encoded_1.length;
        event_i32[pos >> 2] = len_1; pos += 4;
        new Uint8Array(memory.buffer, event_buffer_ptr_val + pos).set(encoded_1);
        pos += (len_1 + 3) & ~3;
        const len = pos - start_pos;
        event_u8[start_pos + 2] = len & 0xFF;
        event_u8[start_pos + 3] = (len >> 8) & 0xFF;
        event_offset_view[0] = pos;
    }
    function push_event_dom_CHANGE(handle, value) {
        if (event_u8.buffer !== memory.buffer) {
            event_u8 = new Uint8Array(memory.buffer, event_buffer_ptr_val);
            event_i32 = new Int32Array(memory.buffer, event_buffer_ptr_val);
            event_f32 = new Float32Array(memory.buffer, event_buffer_ptr_val);
            event_offset_view = new Uint32Array(memory.buffer, event_offset_ptr_val, 1);
        }
        if (event_offset_view[0] + 4096 > EVENT_BUFFER_SIZE) { console.warn('WebCC: Event buffer full, dropping event CHANGE'); return; }
        let pos = event_offset_view[0];
        const start_pos = pos;
        event_u8[pos] = 3;
        pos += 4; // Skip header (opcode + pad + size)
        event_i32[pos >> 2] = handle; pos += 4;
        const encoded_1 = text_encoder.encode(value);
        const len_1 = encoded_1.length;
        event_i32[pos >> 2] = len_1; pos += 4;
        new Uint8Array(memory.buffer, event_buffer_ptr_val + pos).set(encoded_1);
        pos += (len_1 + 3) & ~3;
        const len = pos - start_pos;
        event_u8[start_pos + 2] = len & 0xFF;
        event_u8[start_pos + 3] = (len >> 8) & 0xFF;
        event_offset_view[0] = pos;
    }
    function push_event_dom_KEYDOWN(handle, keycode) {
        if (event_u8.buffer !== memory.buffer) {
            event_u8 = new Uint8Array(memory.buffer, event_buffer_ptr_val);
            event_i32 = new Int32Array(memory.buffer, event_buffer_ptr_val);
            event_f32 = new Float32Array(memory.buffer, event_buffer_ptr_val);
            event_offset_view = new Uint32Array(memory.buffer, event_offset_ptr_val, 1);
        }
        if (event_offset_view[0] + 4096 > EVENT_BUFFER_SIZE) { console.warn('WebCC: Event buffer full, dropping event KEYDOWN'); return; }
        let pos = event_offset_view[0];
        const start_pos = pos;
        event_u8[pos] = 4;
        pos += 4; // Skip header (opcode + pad + size)
        event_i32[pos >> 2] = handle; pos += 4;
        event_i32[pos >> 2] = keycode; pos += 4;
        const len = pos - start_pos;
        event_u8[start_pos + 2] = len & 0xFF;
        event_u8[start_pos + 3] = (len >> 8) & 0xFF;
        event_offset_view[0] = pos;
    }
    function push_event_system_POPSTATE(path) {
        if (event_u8.buffer !== memory.buffer) {
            event_u8 = new Uint8Array(memory.buffer, event_buffer_ptr_val);
            event_i32 = new Int32Array(memory.buffer, event_buffer_ptr_val);
            event_f32 = new Float32Array(memory.buffer, event_buffer_ptr_val);
            event_offset_view = new Uint32Array(memory.buffer, event_offset_ptr_val, 1);
        }
        if (event_offset_view[0] + 4096 > EVENT_BUFFER_SIZE) { console.warn('WebCC: Event buffer full, dropping event POPSTATE'); return; }
        let pos = event_offset_view[0];
        const start_pos = pos;
        event_u8[pos] = 10;
        pos += 4; // Skip header (opcode + pad + size)
        const encoded_0 = text_encoder.encode(path);
        const len_0 = encoded_0.length;
        event_i32[pos >> 2] = len_0; pos += 4;
        new Uint8Array(memory.buffer, event_buffer_ptr_val + pos).set(encoded_0);
        pos += (len_0 + 3) & ~3;
        const len = pos - start_pos;
        event_u8[start_pos + 2] = len & 0xFF;
        event_u8[start_pos + 3] = (len >> 8) & 0xFF;
        event_offset_view[0] = pos;
    }
    const elements = []; elements[0] = document.body;
    const contexts = [];

    // Reusable text decoder to avoid garbage collection overhead
    const decoder = new TextDecoder();
    let u8 = new Uint8Array(memory.buffer);
    let i32 = new Int32Array(memory.buffer);
    let f32 = new Float32Array(memory.buffer);
    let f64 = new Float64Array(memory.buffer);

    function flush(ptr, size) {
        if (size === 0) return;

        if (u8.buffer !== memory.buffer) {
            u8 = new Uint8Array(memory.buffer);
            i32 = new Int32Array(memory.buffer);
            f32 = new Float32Array(memory.buffer);
            f64 = new Float64Array(memory.buffer);
        }

        let pos = ptr;
        const end = ptr + size;

        // Loop through the buffer
        while (pos < end) {
            if (pos + 4 > end) {
                console.error("WebCC: Unexpected end of buffer reading opcode");
                break;
            }
            const opcode = i32[pos >> 2];
            pos += 4;

            switch (opcode) {
                case 7: {
                    if (pos + 4 > end) { console.error('WebCC: OOB handle'); break; }
                    const handle = i32[pos >> 2]; pos += 4;
                    if (pos + 4 > end) { console.error('WebCC: OOB name_len'); break; }
                    const name_len = i32[pos >> 2]; pos += 4;
                    const name_padded = (name_len + 3) & ~3;
                    if (pos + name_padded > end) { console.error('WebCC: OOB name_data'); break; }
                    const name = decoder.decode(u8.subarray(pos, pos + name_len)); pos += name_padded;
                    if (pos + 4 > end) { console.error('WebCC: OOB value_len'); break; }
                    const value_len = i32[pos >> 2]; pos += 4;
                    const value_padded = (value_len + 3) & ~3;
                    if (pos + value_padded > end) { console.error('WebCC: OOB value_data'); break; }
                    const value = decoder.decode(u8.subarray(pos, pos + value_len)); pos += value_padded;
                    { const el = elements[handle]; if(!el){ console.warn('set_attribute: unknown element handle', handle); continue; } el.setAttribute(name, value); }
                    break;
                }
                case 10: {
                    if (pos + 4 > end) { console.error('WebCC: OOB parent_handle'); break; }
                    const parent_handle = i32[pos >> 2]; pos += 4;
                    if (pos + 4 > end) { console.error('WebCC: OOB child_handle'); break; }
                    const child_handle = i32[pos >> 2]; pos += 4;
                    { const parent = elements[parent_handle]; const child = elements[child_handle]; if(!parent || !child){ console.warn('append_child: unknown handles', parent_handle, child_handle); continue; } parent.appendChild(child); }
                    break;
                }
                case 30: {
                    if (pos + 4 > end) { console.error('WebCC: OOB handle'); break; }
                    const handle = i32[pos >> 2]; pos += 4;
                    if (pos + 4 > end) { console.error('WebCC: OOB r'); break; }
                    const r = i32[pos >> 2]; pos += 4;
                    if (pos + 4 > end) { console.error('WebCC: OOB g'); break; }
                    const g = i32[pos >> 2]; pos += 4;
                    if (pos + 4 > end) { console.error('WebCC: OOB b'); break; }
                    const b = i32[pos >> 2]; pos += 4;
                    { const ctx = contexts[handle]; if(!ctx){ console.warn('set_fill_style: unknown context', handle); continue; } ctx.fillStyle = `rgb(${r},${g},${b})`; }
                    break;
                }
                case 32: {
                    if (pos + 4 > end) { console.error('WebCC: OOB handle'); break; }
                    const handle = i32[pos >> 2]; pos += 4;
                    if (pos % 8 !== 0) pos += (8 - (pos % 8));
                    if (pos + 8 > end) { console.error('WebCC: OOB x'); break; }
                    const x = f64[pos >> 3]; pos += 8;
                    if (pos % 8 !== 0) pos += (8 - (pos % 8));
                    if (pos + 8 > end) { console.error('WebCC: OOB y'); break; }
                    const y = f64[pos >> 3]; pos += 8;
                    if (pos % 8 !== 0) pos += (8 - (pos % 8));
                    if (pos + 8 > end) { console.error('WebCC: OOB w'); break; }
                    const w = f64[pos >> 3]; pos += 8;
                    if (pos % 8 !== 0) pos += (8 - (pos % 8));
                    if (pos + 8 > end) { console.error('WebCC: OOB h'); break; }
                    const h = f64[pos >> 3]; pos += 8;
                    { const ctx = contexts[handle]; if(!ctx){ console.warn('fill_rect: unknown context', handle); continue; } ctx.fillRect(x, y, w, h); }
                    break;
                }
                case 38: {
                    if (pos + 4 > end) { console.error('WebCC: OOB handle'); break; }
                    const handle = i32[pos >> 2]; pos += 4;
                    { const ctx = contexts[handle]; if(!ctx){ console.warn('begin_path: unknown context', handle); continue; } ctx.beginPath(); }
                    break;
                }
                case 43: {
                    if (pos + 4 > end) { console.error('WebCC: OOB handle'); break; }
                    const handle = i32[pos >> 2]; pos += 4;
                    { const ctx = contexts[handle]; if(!ctx){ console.warn('fill: unknown context', handle); continue; } ctx.fill(); }
                    break;
                }
                case 44: {
                    if (pos + 4 > end) { console.error('WebCC: OOB handle'); break; }
                    const handle = i32[pos >> 2]; pos += 4;
                    if (pos % 8 !== 0) pos += (8 - (pos % 8));
                    if (pos + 8 > end) { console.error('WebCC: OOB x'); break; }
                    const x = f64[pos >> 3]; pos += 8;
                    if (pos % 8 !== 0) pos += (8 - (pos % 8));
                    if (pos + 8 > end) { console.error('WebCC: OOB y'); break; }
                    const y = f64[pos >> 3]; pos += 8;
                    if (pos % 8 !== 0) pos += (8 - (pos % 8));
                    if (pos + 8 > end) { console.error('WebCC: OOB radius'); break; }
                    const radius = f64[pos >> 3]; pos += 8;
                    if (pos % 8 !== 0) pos += (8 - (pos % 8));
                    if (pos + 8 > end) { console.error('WebCC: OOB start_angle'); break; }
                    const start_angle = f64[pos >> 3]; pos += 8;
                    if (pos % 8 !== 0) pos += (8 - (pos % 8));
                    if (pos + 8 > end) { console.error('WebCC: OOB end_angle'); break; }
                    const end_angle = f64[pos >> 3]; pos += 8;
                    { const ctx = contexts[handle]; if(!ctx){ console.warn('arc: unknown context', handle); continue; } ctx.arc(x, y, radius, start_angle, end_angle); }
                    break;
                }
                case 45: {
                    if (pos + 4 > end) { console.error('WebCC: OOB handle'); break; }
                    const handle = i32[pos >> 2]; pos += 4;
                    if (pos + 4 > end) { console.error('WebCC: OOB text_len'); break; }
                    const text_len = i32[pos >> 2]; pos += 4;
                    const text_padded = (text_len + 3) & ~3;
                    if (pos + text_padded > end) { console.error('WebCC: OOB text_data'); break; }
                    const text = decoder.decode(u8.subarray(pos, pos + text_len)); pos += text_padded;
                    if (pos % 8 !== 0) pos += (8 - (pos % 8));
                    if (pos + 8 > end) { console.error('WebCC: OOB x'); break; }
                    const x = f64[pos >> 3]; pos += 8;
                    if (pos % 8 !== 0) pos += (8 - (pos % 8));
                    if (pos + 8 > end) { console.error('WebCC: OOB y'); break; }
                    const y = f64[pos >> 3]; pos += 8;
                    { const ctx = contexts[handle]; if(ctx) ctx.fillText(text, x, y); }
                    break;
                }
                case 48: {
                    if (pos + 4 > end) { console.error('WebCC: OOB handle'); break; }
                    const handle = i32[pos >> 2]; pos += 4;
                    if (pos + 4 > end) { console.error('WebCC: OOB font_len'); break; }
                    const font_len = i32[pos >> 2]; pos += 4;
                    const font_padded = (font_len + 3) & ~3;
                    if (pos + font_padded > end) { console.error('WebCC: OOB font_data'); break; }
                    const font = decoder.decode(u8.subarray(pos, pos + font_len)); pos += font_padded;
                    { const ctx = contexts[handle]; if(ctx) ctx.font = font; }
                    break;
                }
                case 84: {
                    if (pos + 4 > end) { console.error('WebCC: OOB func'); break; }
                    const func = i32[pos >> 2]; pos += 4;
                    { const fn = table.get(func); if(!fn){ console.error('set_main_loop: function not found in table', func); continue; } const loop = (t) => { fn(t); requestAnimationFrame(loop); }; requestAnimationFrame(loop); }
                    break;
                }
                case 85: {
                    if (pos + 4 > end) { console.error('WebCC: OOB title_len'); break; }
                    const title_len = i32[pos >> 2]; pos += 4;
                    const title_padded = (title_len + 3) & ~3;
                    if (pos + title_padded > end) { console.error('WebCC: OOB title_data'); break; }
                    const title = decoder.decode(u8.subarray(pos, pos + title_len)); pos += title_padded;
                    { document.title = title; }
                    break;
                }

                default:
                    console.error("Unknown opcode:", opcode);
                    return;
            }
        }
    }

    // Run the C++ main function
    if (main) main();
};
run();
