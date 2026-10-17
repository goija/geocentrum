// ==============================================================================
// VORTEX OS v158.1 — Web Audio API Deploy Chime & Telemetry Audio Feedback
// ==============================================================================

const VortexAudioChime = (() => {
  let audioCtx = null;
  let lastKnownStatus = null;

  function getAudioContext() {
    if (!audioCtx) {
      const AudioContextClass = window.AudioContext || window.webkitAudioContext;
      if (AudioContextClass) audioCtx = new AudioContextClass();
    }
    if (audioCtx && audioCtx.state === 'suspended') audioCtx.resume();
    return audioCtx;
  }

  function playSuccessChime() {
    const ctx = getAudioContext();
    if (!ctx) return;
    const now = ctx.currentTime;
    const freqs = [528.0, 792.0, 1056.0];
    
    freqs.forEach((freq, idx) => {
      const osc = ctx.createOscillator();
      const gain = ctx.createGain();

      osc.type = 'sine';
      osc.frequency.setValueAtTime(freq, now + idx * 0.12);

      gain.gain.setValueAtTime(0.001, now + idx * 0.12);
      gain.gain.exponentialRampToValueAtTime(0.2, now + idx * 0.12 + 0.02);
      gain.gain.exponentialRampToValueAtTime(0.0001, now + idx * 0.12 + 0.8);

      osc.connect(gain);
      gain.connect(ctx.destination);

      osc.start(now + idx * 0.12);
      osc.stop(now + idx * 0.12 + 0.85);
    });
  }

  function playFailureAlert() {
    const ctx = getAudioContext();
    if (!ctx) return;
    const now = ctx.currentTime;
    const osc = ctx.createOscillator();
    const gain = ctx.createGain();

    osc.type = 'sawtooth';
    osc.frequency.setValueAtTime(220.0, now);
    osc.frequency.exponentialRampToValueAtTime(110.0, now + 0.5);

    gain.gain.setValueAtTime(0.25, now);
    gain.gain.exponentialRampToValueAtTime(0.001, now + 0.5);

    osc.connect(gain);
    gain.connect(ctx.destination);

    osc.start(now);
    osc.stop(now + 0.55);
  }

  function handleStatusUpdate(newStatus) {
    if (lastKnownStatus !== null && lastKnownStatus !== newStatus) {
      if (newStatus === 'SUCCESS') playSuccessChime();
      else if (newStatus === 'FAILED') playFailureAlert();
    }
    lastKnownStatus = newStatus;
  }

  function initAutoplayUnlock() {
    const unlock = () => {
      getAudioContext();
      window.removeEventListener('click', unlock);
      window.removeEventListener('keydown', unlock);
    };
    window.addEventListener('click', unlock);
    window.addEventListener('keydown', unlock);
  }

  return { playSuccessChime, playFailureAlert, handleStatusUpdate, initAutoplayUnlock };
})();

if (typeof window !== 'undefined') {
  window.VortexAudioChime = VortexAudioChime;
  VortexAudioChime.initAutoplayUnlock();
}
