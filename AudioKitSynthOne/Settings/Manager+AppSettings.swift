//
//  Manager+AppSettingsDataManager.swift
//  AudioKitSynthOne
//
//  Created by AudioKit Contributors on 10/31/17.
//  Copyright © 2018 AudioKit. All rights reserved.
//

import AudioKit
import UIKit
import Disk

extension Manager {

    // MARK: - Convert App Settings to Controls and vice-versa

    func setDefaultsFromAppSettings() {

        // MIDI
        //conductor.backgroundAudioOn = appSettings.backgroundAudioOn
        midiChannelIn = MIDIByte(appSettings.midiChannel)
        omniMode = appSettings.omniMode

        // DEV PANEL
        devViewController.freezeArpRate.value = (appSettings.freezeArpRate == true ? 1 : 0)
        devViewController.freezeDelay.value = (appSettings.freezeDelay == true ? 1 : 0)
        devViewController.freezeReverb.value = (appSettings.freezeReverb == true ? 1 : 0)

        // DSP parameter stored in app settings
        conductor.synth.setSynthParameter(.portamentoHalfTime, appSettings.portamentoHalfTime)
        devViewController.portamento.value = conductor.synth.getSynthParameter(.portamentoHalfTime)

        // MIDI Learn
        mainPanel.masterVolume.midiCC = MIDIByte(appSettings.masterVolumeCC)
        mainPanel.morph1SemitoneOffset.midiCC = MIDIByte(appSettings.morph1SemitoneOffsetCC)
        mainPanel.morph2SemitoneOffset.midiCC = MIDIByte(appSettings.morph2SemitoneOffsetCC)
        mainPanel.morph2Detuning.midiCC = MIDIByte(appSettings.morph2DetuningCC)
        mainPanel.morphBalance.midiCC = MIDIByte(appSettings.morphBalanceCC)
        mainPanel.morph1Volume.midiCC = MIDIByte(appSettings.morph1VolumeCC)
        mainPanel.morph2Volume.midiCC = MIDIByte(appSettings.morph2VolumeCC)
        mainPanel.subVolume.midiCC = MIDIByte(appSettings.subVolumeCC)
        mainPanel.fmVolume.midiCC = MIDIByte(appSettings.fmVolumeCC)
        mainPanel.fmAmount.midiCC = MIDIByte(appSettings.fmAmountCC)
        mainPanel.noiseVolume.midiCC = MIDIByte(appSettings.noiseVolumeCC)
        mainPanel.glideKnob.midiCC = MIDIByte(appSettings.glideKnobCC)
        mainPanel.cutoff.midiCC = MIDIByte(appSettings.cutoffCC)
        mainPanel.resonance.midiCC = MIDIByte(appSettings.rezCC)

        arpSeqPanel.arpInterval.midiCC = MIDIByte(appSettings.arpIntervalCC)

        adsrPanel.attackKnob.midiCC = MIDIByte(appSettings.attackKnobCC)
        adsrPanel.decayKnob.midiCC = MIDIByte(appSettings.decayKnobCC)
        adsrPanel.sustainKnob.midiCC = MIDIByte(appSettings.sustainKnobCC)
        adsrPanel.releaseKnob.midiCC = MIDIByte(appSettings.releaseKnobCC)
        adsrPanel.filterAttackKnob.midiCC = MIDIByte(appSettings.filterAttackKnobCC)
        adsrPanel.filterDecayKnob.midiCC = MIDIByte(appSettings.filterDecayKnobCC)
        adsrPanel.filterSustainKnob.midiCC = MIDIByte(appSettings.filterSustainKnobCC)
        adsrPanel.filterReleaseKnob.midiCC = MIDIByte(appSettings.filterReleaseKnobCC)
        adsrPanel.filterADSRMixKnob.midiCC = MIDIByte(appSettings.filterADSRMixKnobCC)

        fxPanel.sampleRate.midiCC = MIDIByte(appSettings.sampleRateCC)
        fxPanel.autoPanRate.midiCC = MIDIByte(appSettings.autoPanRateCC)
        fxPanel.reverbSize.midiCC = MIDIByte(appSettings.reverbSizeCC)
        fxPanel.reverbLowCut.midiCC = MIDIByte(appSettings.reverbLowCutCC)
        fxPanel.reverbMix.midiCC = MIDIByte(appSettings.reverbMixCC)
        fxPanel.delayTime.midiCC = MIDIByte(appSettings.delayTimeCC)
        fxPanel.delayFeedback.midiCC = MIDIByte(appSettings.delayFeedbackCC)
        fxPanel.delayMix.midiCC = MIDIByte(appSettings.delayMixCC)
        fxPanel.lfo1Amp.midiCC = MIDIByte(appSettings.lfo1AmpCC)
        fxPanel.lfo2Amp.midiCC = MIDIByte(appSettings.lfo2AmpCC)
        fxPanel.lfo1Rate.midiCC = MIDIByte(appSettings.lfo1RateCC)
        fxPanel.lfo2Rate.midiCC = MIDIByte(appSettings.lfo2RateCC)
        fxPanel.phaserMix.midiCC = MIDIByte(appSettings.phaserMixCC)
        fxPanel.phaserRate.midiCC = MIDIByte(appSettings.phaserRateCC)
        fxPanel.phaserFeedback.midiCC = MIDIByte(appSettings.phaserFeedbackCC)
        fxPanel.phaserNotchWidth.midiCC = MIDIByte(appSettings.phaserNotchWidthCC)

        // keyboard
        keyboardView.labelMode = appSettings.labelMode
        keyboardView.octaveCount = appSettings.octaveRange
        keyboardView.darkMode = appSettings.darkMode

        //TODO: Persist AudioPlot fill?
    }

    func saveAppSettingValues() {

        // MIDI
        // appSettings.backgroundAudioOn = conductor.backgroundAudioOn
        appSettings.midiChannel = Int(midiChannelIn)
        appSettings.omniMode = omniMode
        appSettings.freezeArpRate = (devViewController.freezeArpRate.value == 1 ? true : false)
        appSettings.freezeDelay = (devViewController.freezeDelay.value == 1 ? true : false)
        appSettings.freezeReverb = (devViewController.freezeReverb.value == 1 ? true : false)

        //
        appSettings.portamentoHalfTime = conductor.synth.getSynthParameter(.portamentoHalfTime)

        // MIDI Learn
        appSettings.masterVolumeCC = Int(mainPanel.masterVolume.midiCC)
        appSettings.morph1SemitoneOffsetCC = Int(mainPanel.morph1SemitoneOffset.midiCC)
        appSettings.morph2SemitoneOffsetCC = Int(mainPanel.morph2SemitoneOffset.midiCC)
        appSettings.morph2DetuningCC = Int(mainPanel.morph2Detuning.midiCC)
        appSettings.morphBalanceCC = Int(mainPanel.morphBalance.midiCC)
        appSettings.morph1VolumeCC = Int(mainPanel.morph1Volume.midiCC)
        appSettings.morph2VolumeCC = Int(mainPanel.morph2Volume.midiCC)
        appSettings.subVolumeCC = Int(mainPanel.subVolume.midiCC)
        appSettings.fmVolumeCC = Int(mainPanel.fmVolume.midiCC)
        appSettings.fmAmountCC = Int(mainPanel.fmAmount.midiCC)
        appSettings.noiseVolumeCC = Int(mainPanel.noiseVolume.midiCC)
        appSettings.glideKnobCC = Int(mainPanel.glideKnob.midiCC)
        appSettings.cutoffCC = Int(mainPanel.cutoff.midiCC)
        appSettings.rezCC = Int(mainPanel.resonance.midiCC)

        appSettings.arpIntervalCC = Int(arpSeqPanel.arpInterval.midiCC)

        appSettings.attackKnobCC = Int(adsrPanel.attackKnob.midiCC)
        appSettings.decayKnobCC = Int(adsrPanel.decayKnob.midiCC)
        appSettings.sustainKnobCC = Int(adsrPanel.sustainKnob.midiCC)
        appSettings.releaseKnobCC = Int(adsrPanel.releaseKnob.midiCC)
        appSettings.filterAttackKnobCC = Int(adsrPanel.filterAttackKnob.midiCC)
        appSettings.filterDecayKnobCC = Int(adsrPanel.filterDecayKnob.midiCC)
        appSettings.filterSustainKnobCC = Int(adsrPanel.filterSustainKnob.midiCC)
        appSettings.filterReleaseKnobCC = Int(adsrPanel.filterReleaseKnob.midiCC)
        appSettings.filterADSRMixKnobCC = Int(adsrPanel.filterADSRMixKnob.midiCC)

        appSettings.sampleRateCC = Int(fxPanel.sampleRate.midiCC)
        appSettings.autoPanRateCC = Int(fxPanel.autoPanRate.midiCC)
        appSettings.reverbSizeCC = Int(fxPanel.reverbSize.midiCC)
        appSettings.reverbLowCutCC = Int(fxPanel.reverbLowCut.midiCC)
        appSettings.reverbMixCC = Int(fxPanel.reverbMix.midiCC)
        appSettings.delayTimeCC = Int(fxPanel.delayTime.midiCC)
        appSettings.delayFeedbackCC = Int(fxPanel.delayFeedback.midiCC)
        appSettings.delayMixCC = Int(fxPanel.delayMix.midiCC)
        appSettings.lfo1AmpCC = Int(fxPanel.lfo1Amp.midiCC)
        appSettings.lfo2AmpCC = Int(fxPanel.lfo2Amp.midiCC)
        appSettings.lfo1RateCC = Int(fxPanel.lfo1Rate.midiCC)
        appSettings.lfo2RateCC = Int(fxPanel.lfo2Rate.midiCC)
        appSettings.phaserMixCC = Int(fxPanel.phaserMix.midiCC)
        appSettings.phaserRateCC = Int(fxPanel.phaserRate.midiCC)
        appSettings.phaserFeedbackCC = Int(fxPanel.phaserFeedback.midiCC)
        appSettings.phaserNotchWidthCC = Int(fxPanel.phaserNotchWidth.midiCC)

        // keyboard
        appSettings.labelMode = keyboardView.labelMode
        appSettings.octaveRange = keyboardView.octaveCount
        appSettings.darkMode = keyboardView.darkMode
        appSettings.showKeyboard = keyboardToggle.value

        appSettings.plotFilled = mainPanel.isAudioPlotFilled
        saveAppSettings()
    }

    // MARK: - Load / Save App Settings

    // Load App Settings from Device
    func loadSettingsFromDevice() {
        do {
            let retrievedSettingData = try Disk.retrieve("settings.json", from: .documents, as: Data.self)
            let settingsJSON = try? JSONSerialization.jsonObject(with: retrievedSettingData, options: [])

            if let settingDictionary = settingsJSON as? [String: Any] {
                appSettings = AppSettings(dictionary: settingDictionary)
            }

            setDefaultsFromAppSettings()

        } catch {
            AKLog("*** error loading")
        }
    }

    func saveAppSettings() {
        do {
            try Disk.save(appSettings, to: .documents, as: "settings.json")
        } catch {
            AKLog("error saving")
        }
    }

    // MARK: - Load / Save Bank Settings

    func saveBankSettings() {
        do {
            try Disk.save(conductor.banks, to: .documents, as: "banks.json")
        } catch {
            AKLog("error saving")
        }
    }

    func loadBankSettings() {
        do {
            let retrievedSettingData = try Disk.retrieve("banks.json", from: .documents, as: Data.self)
            let banksJSON = try? JSONSerialization.jsonObject(with: retrievedSettingData, options: [])

            guard let jsonArray = banksJSON as? [Any] else { return }
            var banks = [Bank]()
            for bankJSON in jsonArray {
                if let bankDictionary = bankJSON as? [String: Any] {
                    let retrievedBank = Bank(dictionary: bankDictionary)
                    banks.append(retrievedBank)
                }
            }
            conductor.banks = banks

        } catch {
            AKLog("*** error loading")
        }
    }

    func createInitBanks() {

        for (i, bankName) in initBanks.enumerated() {
            let bank = Bank(name: bankName, position: i)
            conductor.banks.append(bank)
        }

        saveBankSettings()
    }

}