//
//  ViewController.swift
//  testLib
//
//  Created by  vkrotin on 22.09.2021.
//

import UIKit
import CRUploadLib

class ViewController: UIViewController, CRUploadDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var pauseButton: UIButton!
    
    var uploadFile: CRUploadFile? {
        didSet {
            self.imageView.image = uploadFile?.thumbImage
            let isEmptyFile = uploadFile == nil
            if isEmptyFile {
                progressView.setProgress(0, animated: false)
                isPause = false
            }
            progressView.isHidden = isEmptyFile
            progressLabel.isHidden = isEmptyFile
        }
    }
    
    var isPause = false {
        didSet {
            let text = isPause ? "Resume" : "Pause"
            pauseButton.setTitle(text, for: .normal)
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //serverInitial()
        // uploadSettingsInitial()
        pauseButton.setTitle("Pause", for: .normal)
        UploadManager.shared.fetch()

        
        UploadManager.shared.dataSource = self
        UploadManager.shared.delegate = self
        progressView.isHidden = true
        progressLabel.isHidden = true
    }
    
    
    //
    // Install your server schemes like this
    //
    private func serverInitial() {
        CRSetting.shared.update(mainURL: "192,0.0.1", port: 80, sheme: "http")
    }
    
    //
    // upload settings
    // Attention: Now default optimal settings already set!
    // If you change it, there may be failures in uploading
    //
    private func uploadSettingsInitial() {
        UploadSettings.shared.update(thread: 5, chunkSize: 1, uploadType: .asyncThread)
    }

}

extension ViewController {
    
    @IBAction func testTouch(_ sender: Any) {
        MediaPicker.share.present(in: self) { url in
            UploadManager.shared.addNew(media: url) {[weak self] headFile, tempUrl, thumbImage in
                self?.imageView.image = thumbImage
            }
        }
    }

    @IBAction func pauseResumeTouch(_ sender: UIButton) {
        
        guard let file = uploadFile else { return }
        UploadManager.shared.pauseOrResume(file.id) { [weak self] in
            // do something after pause/resume
            guard let self = self else { return }
            self.isPause = !self.isPause
        }
    }
    
    @IBAction func removeFile(_ sender: Any) {
        // do remove file from disk and stop upload (bonus)
        guard let file = uploadFile else { return }
        UploadManager.shared.remove(file)
 
    }
    
}

extension ViewController : CRDataSourceDelegate {
   
    //
    // do something after add new upload, now doing auto-start upload
    //
    func addNew(_ file: CRUploadFile) {
        UploadManager.shared.startUpload(with: file)
        progressView.isHidden = false
        progressLabel.isHidden = false
    }
    
    //
    // do something after remove file, now cleared temp upload file
    //
    func remove(fileId: String?) {
        uploadFile = nil
    }
    
    
    //
    // do something with all files after sync with server
    // files - now it's array from temp DB
    //
    func syncAllUploads(files: [CRUpload]) {
        print("All Files: \(files.count)")
    }
    
}

extension ViewController: UploadServiceDelegate {
    
    //
    // do something with progress file after upload chunk on server
    // file - uploading file
    // progress - progress of uploading file
    // textProgress - simply display text of uploading/TotalSize MB ( ex: 123/876 MB )
    //
    
    func uploadProgress(file: CRUploadFile, progress: Float, textProgress: String) {
        
        DispatchQueue.main.async { [weak self] in
            
            if self?.uploadFile == nil {
                self?.uploadFile = file
                self?.progressView.isHidden = false
                self?.progressLabel.isHidden = false
            }
            
            self?.progressView.setProgress(progress, animated: true)
            self?.progressLabel.text = textProgress
            self?.progressLabel.sizeToFit()
        }
    }
    
    //
    // do something with file after complete upload
    //
    
    func uploadFinish(file: CRUploadFile) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            CRAlertView.showAlert(on: self, file.id, nil)
            self.uploadFile = nil
        }

    }
    
    
}
