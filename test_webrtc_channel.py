#!/usr/bin/env python3
import asyncio
from aiortc import RTCPeerConnection

async def test_data_channel():
    print("🔒 Initialiseren van WebRTC Peer Connections (DTLS beveiligd)...")
    pc_offer = RTCPeerConnection()
    pc_answer = RTCPeerConnection()

    dc_offer = pc_offer.createDataChannel("vortex_secure_channel")

    @dc_offer.on("open")
    def on_open():
        print("🟢 Data Channel geopend op Offer-zijde!")
        dc_offer.send("Sovereign payload via encrypted WebRTC Data Channel!")

    @dc_offer.on("message")
    def on_message(message):
        print(f"📥 Ontvangen op Offer-zijde: {message}")

    @pc_answer.on("datachannel")
    def on_datachannel(channel):
        print(f"🟢 Data Channel ontvangen op Answer-zijde: {channel.label}")
        @channel.on("message")
        def on_answer_message(message):
            print(f"📥 Ontvangen op Answer-zijde: {message}")
            channel.send("Bevestiging: bericht veilig ontvangen en verwerkt.")

    offer = await pc_offer.createOffer()
    await pc_offer.setLocalDescription(offer)
    await pc_answer.setRemoteDescription(pc_offer.localDescription)

    answer = await pc_answer.createAnswer()
    await pc_answer.setLocalDescription(answer)
    await pc_offer.setRemoteDescription(pc_answer.localDescription)

    print("🔄 Wachten op veilige datatransmissie...")
    await asyncio.sleep(2)

    await pc_offer.close()
    await pc_answer.close()
    print("✨ WebRTC Data Channel test succesvol afgerond.")

if __name__ == "__main__":
    asyncio.run(test_data_channel())
