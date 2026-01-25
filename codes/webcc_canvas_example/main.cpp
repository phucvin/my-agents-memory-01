#include "webcc/canvas.h"
#include "webcc/dom.h"
#include "webcc/system.h"

// Global state
webcc::Canvas canvas;
webcc::CanvasContext2D ctx;
float x = 50.0f;
float y = 50.0f;
float dx = 3.0f;
float dy = 2.0f;
float radius = 20.0f;
int width = 600;
int height = 400;

void update(float dt) {
    // Clear background
    webcc::canvas::set_fill_style(ctx, 240, 240, 240);
    webcc::canvas::fill_rect(ctx, 0, 0, width, height);

    // Update position
    x += dx;
    y += dy;

    // Bounce logic
    if (x + radius > width || x - radius < 0) {
        dx = -dx;
    }
    if (y + radius > height || y - radius < 0) {
        dy = -dy;
    }

    // Draw ball
    webcc::canvas::begin_path(ctx);
    webcc::canvas::arc(ctx, x, y, radius, 0, 6.28f);
    webcc::canvas::set_fill_style(ctx, 255, 0, 0); // Red
    webcc::canvas::fill(ctx);

    // Draw text
    webcc::canvas::set_fill_style(ctx, 0, 0, 0);
    webcc::canvas::set_font(ctx, "20px Arial");
    webcc::canvas::fill_text(ctx, "WebCC Bouncing Ball", 20, 30);

    webcc::flush();
}

int main() {
    webcc::system::set_title("WebCC Bouncing Ball");

    webcc::DOMElement body = webcc::dom::get_body();
    webcc::dom::set_attribute(body, "style", "display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; background-color: #333;");

    // Create canvas
    canvas = webcc::canvas::create_canvas("myCanvas", width, height);
    ctx = webcc::canvas::get_context_2d(canvas);

    // Add border to canvas
    webcc::dom::set_attribute(canvas, "style", "border: 2px solid white; box-shadow: 0 0 10px rgba(0,0,0,0.5);");

    webcc::dom::append_child(body, canvas);

    webcc::system::set_main_loop(update);
    webcc::flush();
    return 0;
}
