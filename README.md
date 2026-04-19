# macOS Screen Recorder Scheduler

A robust shell script for macOS designed to automate QuickTime screen recordings. It features a timed stop via system signals, custom file naming, and an optional scheduled start time. This is ideal for capturing live performances or streams (like Coachella) when you are away from your computer.

## 🎧 Pre-Setup: Routing Audio
By default, macOS cannot record system audio. You must route it through a virtual device.
1. Download and install [BlackHole 2ch](https://existential.audio/blackhole/).
2. Change your Mac's **Audio Output** to **BlackHole 2ch**:
   - Click the **Speaker icon** in the top menu bar and select **BlackHole 2ch**.
   - Alternatively, go to **Settings > Sound > Output** and select **BlackHole 2ch**.
3. Set **"Play sound effects through"** to **BlackHole 2ch** in the same menu to ensure system alerts are captured.

## 🎥 Pre-Setup: QuickTime Configuration
QuickTime "remembers" your last manually used settings. Configure these once before running the script:
1. Open **QuickTime Player** and go to **File > New Screen Recording**.
2. Click the **Record Selected Portion** button and drag the crop box over your desired area (e.g., the YouTube player).
3. Click **Options** and under the **Microphone** section, select **BlackHole 2ch**.
4. **Test it:** Perform a 5-second manual recording. Play it back to ensure the crop and audio are correct. If it works, the script is ready.

## 🚀 Running the Script

### 1. Give Execution Permissions
Open Terminal and navigate to the folder where you saved the script. Run the following command to allow it to execute:
```bash
chmod +x ./screen_record_timer.sh
```

### 2. Run/Schedule the Script
The script takes two parameters: **Duration (seconds)** and an **Optional Start Time (HH:MM)**.

- **Record Immediately (e.g., for 30 seconds):**
  `./screen_record_timer.sh 30`
- **Schedule for Later (e.g., 1 hour at 11:30 PM):**
  `./screen_record_timer.sh 3600 23:30`
- **Default (Starts now, records for 60 seconds):**
  `./screen_record_timer.sh`

### 3. Enable macOS Permissions
To allow the script to interact with the UI and system processes, you must grant permissions:
- **Accessibility:** Go to **System Settings > Privacy & Security > Accessibility** and toggle **ON** for **Terminal**.
- **Screen Recording:** Go to **System Settings > Privacy & Security > Screen Recording** and toggle **ON** for **Terminal** and **QuickTime Player**.
- **Automation:** Ensure **Terminal** is allowed to control **QuickTime Player** under **Privacy & Security > Automation**.

---
**Note:** Ensure your MacBook Pro is connected to power and set to "Prevent automatic sleeping when the display is off" in **Settings > Displays > Advanced** so the recording is not interrupted.