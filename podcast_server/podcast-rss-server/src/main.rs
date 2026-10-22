use axum::{
    routing::get,
    response::IntoResponse,
    Router,
};
use std::net::SocketAddr;
use tower_http::services::ServeDir;

#[tokio::main]
async fn main() {
    let app = Router::new()
        .route("/rss.xml", get(rss_handler))
        .nest_service("/podcasts", ServeDir::new("./podcasts"));

    let addr = SocketAddr::from(([0, 0, 0, 0], 8080));
    println!("🎙️ VORTEX RSS Podcast Server gestart op http://{}", addr);
    
    let listener = tokio::net::TcpListener::bind(&addr).await.unwrap();
    axum::serve(listener, app).await.unwrap();
}

async fn rss_handler() -> impl IntoResponse {
    let podcast_dir = "./podcasts";
    let mut items_xml = String::new();

    if let Ok(entries) = std::fs::read_dir(podcast_dir) {
        for entry in entries.flatten() {
            let path = entry.path();
            if path.extension().and_then(|s| s.to_str()) == Some("mp3") {
                let filename = path.file_name().unwrap().to_string_lossy().to_string();
                let title = filename
                    .trim_end_matches(".mp3")
                    .replace('_', " ")
                    .replace('-', " ");

                let length = std::fs::metadata(&path).map(|m| m.len()).unwrap_or(0);

                items_xml.push_str(&format!(
                    r#"
                    <item>
                        <title>{}</title>
                        <enclosure url="http://localhost:8080/podcasts/{}" length="{}" type="audio/mpeg"/>
                        <guid>{}</guid>
                    </item>
                    "#,
                    title, filename, length, filename
                ));
            }
        }
    }

    let rss_feed = format!(
        r#"<?xml version="1.0" encoding="UTF-8" ?>
        <rss version="2.0">
            <channel>
                <title>VORTEX Sovereign Podcast Feed</title>
                <link>http://localhost:8080/rss.xml</link>
                <description>Automatisch gegenereerde lokale podcast feed</description>
                <language>nl-NL</language>
                {}
            </channel>
        </rss>"#,
        items_xml
    );

    ([(axum::http::header::CONTENT_TYPE, "application/rss+xml; charset=utf-8")], rss_feed)
}
