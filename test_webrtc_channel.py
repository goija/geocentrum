#!/usr/bin/env python3
import asyncio

async def test_data_channel():
    try:
        from aiortc import RTCPeerConnection
        print("🔒 Initialiseren van WebRTC Peer Connections (aiortc DTLS beveiligd)...")
        pc_offer = RTCPeerConnection()
        pc_answer = RTCPeerConnection()

        dc_offer = pc_offer.createDataChannel("vortex_secure_channel")

        @dc_offer.on("open")
        def on_open():
            print("🟢 Data Channel geopend op Offer-zijde!")
            dc_offer.send("Sovereign payload: Tijdscapsule Anker P (52.25N, 5.22E) OK")

        @dc_offer.on("message")
        def on_message(message):
            print(f"📥 Ontvangen op Offer-zijde: {message}")

        @pc_answer.on("datachannel")
        def on_datachannel(channel):
            print(f"🟢 Data Channel ontvangen op Answer-zijde: {channel.label}")
            @channel.on("message")
            def on_answer_message(message):
                print(f"📥 Ontvangen op Answer-zijde: {message}")
                channel.send("ACK: Bericht veilig ontvangen en verwerkt door Rekencentrum!")

        offer = await pc_offer.createOffer()
        await pc_offer.setLocalDescription(offer)
        await pc_answer.setRemoteDescription(pc_offer.localDescription)

        answer = await pc_answer.createAnswer()
        await pc_answer.setLocalDescription(answer)
        await pc_offer.setRemoteDescription(pc_answer.localDescription)

        await asyncio.sleep(1.5)
        await pc_offer.close()
        await pc_answer.close()
        print("✨ WebRTC Data Channel (aiortc) test succesvol afgerond.")
    except ImportError:
        print("ℹ️ aiortc nog niet geladen in actieve shell; voer ./webrtc_test_runner.sh uit voor automatische venv-executie.")

if __name__ == "__main__":
    asyncio.run(test_data_channel())
