use serde::Serialize;

#[derive(Debug, Clone, Serialize)]
pub struct HingeState {
    pub sector_64: u8,
    pub bits_str: String,
    pub hinge_t: String,
    pub n2_bits: String,
    pub matrix_x: u8,
    pub matrix_y: u8,
}

pub fn compute_hinge_state(theta_deg: f64, nonius: i32) -> HingeState {
    let norm_theta = theta_deg.rem_euclid(360.0);
    let sector = ((norm_theta / 5.625).floor() as u8) & 0x3F;

    let bits_val: u8 = if sector < 32 {
        63 - sector
    } else {
        sector - 32
    };

    let t_val = (bits_val >> 2) & 0b11;
    let n2_val = (t_val << 4) | (t_val << 2) | t_val;

    let nonius_norm = (nonius.unsigned_abs() as f64 / 26214.0).clamp(0.0, 1.0);
    let matrix_x = ((nonius_norm * 64.0).floor() as u8).min(63);
    let matrix_y = sector;

    HingeState {
        sector_64: sector,
        bits_str: format!("{:06b}", bits_val),
        hinge_t: format!("{:02b}", t_val),
        n2_bits: format!("{:06b}", n2_val),
        matrix_x,
        matrix_y,
    }
}
