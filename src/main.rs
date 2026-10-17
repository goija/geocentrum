mod iching_matrix;
mod planimeter;

use axum::{
    extract::ws::{Message, WebSocket, WebSocketUpgrade},
    response::IntoResponse,
    routing::get,
    Router,
};
use planimeter::PlanimeterInput;
use std::net::SocketAddr;
use tower_http::services::ServeDir;

#[tokio::main]
async fn main() {
    let app = Router::new()
        .route("/vortex/ws", get(ws_handler))
        .nest_service("/assets", ServeDir::new("assets"))
        .nest_service("/data", ServeDir::new("data"))
        .nest_service("/domeinen", ServeDir::new("domeinen"))
        .fallback_service(ServeDir::new("web"));

    let mut listener = None;
    for port in [8080, 8088, 8089, 8090] {
        let addr = SocketAddr::from(([127, 0, 0, 1], port));
        if let Ok(l) = tokio::net::TcpListener::bind(addr).await {
            println!("[VORTEX OS v157.0] Server actief op http://{}", addr);
            println!("[VORTEX OS v157.0] Open dashboard: http://{}/vortex_matrix_tab.html", addr);
            listener = Some(l);
            break;
        } else {
            println!("[VORTEX OS] Poort {} is bezet, probeer volgende poort...", port);
        }
    }

    let listener = listener.expect("Geen vrije poort gevonden tussen 8080 en 8090");
    axum::serve(listener, app).await.unwrap();
}

async fn ws_handler(ws: WebSocketUpgrade) -> impl IntoResponse {
    ws.on_upgrade(handle_socket)
}

async fn handle_socket(mut socket: WebSocket) {
    let init_state = PlanimeterInput {
        label: "Laren P (52.250°N, 5.220°E)".to_string(),
        theta_deg: 45.0,
        rho_cm: -8.20,
        nonius: -264,
        sigma: -1.0,
    }
    .evaluate();

    if let Ok(json) = serde_json::to_string(&init_state) {
        let _ = socket.send(Message::Text(json)).await;
    }

    while let Some(Ok(Message::Text(text))) = socket.recv().await {
        if let Ok(input) = serde_json::from_str::<PlanimeterInput>(&text) {
            let packet = input.evaluate();
            if let Ok(resp) = serde_json::to_string(&packet) {
                let _ = socket.send(Message::Text(resp)).await;
            }
        }
    }
}
