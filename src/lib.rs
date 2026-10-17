use wasm_bindgen::prelude::*;
use serde::{Serialize, Deserialize};

#[derive(Serialize, Deserialize)]
pub struct GeodeticVectorResult {
    pub angle_deg: f64,
    pub wavelength_nm: f64,
    pub Snellius_refraction_deg: f64,
    pub opl_cm: f64,
    pub status: String,
}

#[wasm_bindgen]
pub fn calculate_vortex_vector(azimuth: f64, refractive_index_air: f64, refractive_index_water: f64) -> JsValue {
    let opl = 16.67 * refractive_index_air;
    let sin_theta2 = (refractive_index_air / refractive_index_water) * (15.0f64.to_radians()).sin();
    let theta2 = sin_theta2.asin().to_degrees();
    let refraction_delta = 15.0 - theta2;

    let result = GeodeticVectorResult {
        angle_deg: azimuth,
        wavelength_nm: 589.0,
        Snellius_refraction_deg: -refraction_delta,
        opl_cm: (opl * 1000.0).round() / 1000.0,
        status: "WASM_GEODETIC_LOCK_OK".to_string(),
    };

    serde_wasm_bindgen::to_value(&result).unwrap_or(JsValue::NULL)
}
