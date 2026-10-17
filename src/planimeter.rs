use serde::{Deserialize, Serialize};
use crate::iching_matrix::{compute_hinge_state, HingeState};

#[derive(Debug, Clone, Deserialize)]
pub struct PlanimeterInput {
    pub label: String,
    pub theta_deg: f64,
    pub rho_cm: f64,
    pub nonius: i32,
    pub sigma: f64,
}

#[derive(Debug, Clone, Serialize)]
pub struct TelemetryPacket {
    pub label: String,
    pub x_cm: f64,
    pub y_cm: f64,
    pub theta_deg: f64,
    pub rho_cm: f64,
    pub sigma: f64,
    pub nonius: i32,
    pub area_cm2: f64,
    pub lon_geojson: f64,
    pub lat_plat: f64,
    pub lat_neg: f64,
    pub lat_active: f64,
    pub lon_kml: f64,
    pub lat_kml: f64,
    pub hinge: HingeState,
}

impl PlanimeterInput {
    pub fn evaluate(&self) -> TelemetryPacket {
        let rad = self.theta_deg.to_radians();
        let r = self.rho_cm.abs();
        let x_cm = (r * rad.sin() * 100.0).round() / 100.0;
        let y_cm = (-r * rad.cos() * 100.0).round() / 100.0;

        let lon_geojson = 1.85 + 0.78 * x_cm;
        let lat_neg = 47.25 + 0.52 * y_cm;
        let lat_plat = 47.25 - 0.338 * y_cm;

        // Interpoleer tussen PLAT (sigma = 1.0) en NEG (sigma = -1.0)
        let t_sigma = ((self.sigma + 1.0) / 2.0).clamp(0.0, 1.0);
        let lat_active = lat_neg + t_sigma * (lat_plat - lat_neg);

        let lon_kml = 1.85 + (x_cm / 1.15);
        let lat_kml = 47.25 + (y_cm / 1.45);

        TelemetryPacket {
            label: self.label.clone(),
            x_cm,
            y_cm,
            theta_deg: self.theta_deg,
            rho_cm: self.rho_cm,
            sigma: self.sigma,
            nonius: self.nonius,
            area_cm2: self.nonius as f64 * 0.1,
            lon_geojson,
            lat_plat,
            lat_neg,
            lat_active,
            lon_kml,
            lat_kml,
            hinge: compute_hinge_state(self.theta_deg, self.nonius),
        }
    }
}
