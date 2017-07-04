//
//  SmartConfig.swift
//  SmartConfig
//
//  Created by 翟怀楼 on 2017/5/6.
//  Copyright © 2017年 翟怀楼. All rights reserved.
//

import UIKit

class SmartConfigViewController: UIViewController {
    
    var SSID:String = ""
    var PASS:String = ""
    var BSSID:String = ""
    
    var isConfirmState: Bool!
    
    var condition:NSCondition!
    var esptouchTask: ESPTouchTask!
    var esptouchDelegate: EspTouchDelegateImpl!
    
    @IBOutlet weak var wifiName: UILabel!
    @IBOutlet weak var wifiPass: CustomTextField!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var confirmCancelBtn: SystemButton!
    
    @IBAction func tapConfirmForResult(_ sender: SystemButton) {
        if isConnectWiFi() {
            if wifiPass.text != "" {
                SSID = getwifi().getSSID()!
                PASS = wifiPass.text!
                BSSID = getwifi().getBSSID()!
                self.tapConfirmForResult()
            } else {
                let title = NSLocalizedString("WIFI_INPUT_PASSWORD", comment: "")
                let butonTitle = NSLocalizedString("CONFIRM", comment: "")
                
                let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
                let doneButton = UIAlertAction(title: butonTitle, style: .default, handler: nil)
                alert.addAction(doneButton)
                self.present(alert, animated: true, completion: nil)
            }
            
        } else {
            let title = NSLocalizedString("WIFI_DISCONNECTED", comment: "")
            let butonTitle = NSLocalizedString("CONFIRM", comment: "")
            let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
            let doneButton = UIAlertAction(title: butonTitle, style: .default, handler: nil)
            alert.addAction(doneButton)
            self.present(alert, animated: true, completion: nil)
            return
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 解决导航栏跳转变黑1s的BUG
        self.navigationController?.view.backgroundColor = UIColor.white
        
        // 初始化同步锁
        condition = NSCondition()
        
        // 代理
        esptouchDelegate = EspTouchDelegateImpl()
        
        // 初始化按钮配置状态
        self.isConfirmState = false
        
        enableConfirmBtn()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // 每次载入都刷新无线网络的状态
        loadingNetworkStatus()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadingNetworkStatus() {
        let wifiSSID = getwifi().getSSID()
        
        guard wifiSSID != nil else {
            let text = NSLocalizedString("WIFI_DISCONNECTED", comment: "")
            wifiName.text = text
            return
        }
        let text = NSLocalizedString("WIFI_CONNECTED", comment: "")
        wifiName.text = text + wifiSSID!
    }
    
    func isConnectWiFi() -> Bool {
        let wifiSSID = getwifi().getSSID()
        return wifiSSID != nil ? true : false
    }
    
    
    func tapConfirmForResult() {
        if isConfirmState {
            spinner.startAnimating()
            enableCancelBtn()
            print("正在进行配置...")
            let queue = DispatchQueue.global(qos: .default)
            queue.async {
                print("线程正在工作...")
                let esptouchResult: ESPTouchResult = self.executeForResult()
                DispatchQueue.main.async(execute: {
                    self.spinner.stopAnimating()
                    self.enableConfirmBtn()
                    
                    let resultTitle = NSLocalizedString("RESULT_TITLE", comment: "")
                    let confirmSring = NSLocalizedString("CONFIRM", comment: "")
                    
                    if !esptouchResult.isCancelled {
                        UIAlertView(title: resultTitle, message: esptouchResult.description, delegate: nil, cancelButtonTitle: confirmSring).show()
                        // IP拼接
                        /*
                        let strIP = String(esptouchResult.ipAddrData[0]) + "." + String(esptouchResult.ipAddrData[1]) + "." + String(esptouchResult.ipAddrData[2]) + "." + String(esptouchResult.ipAddrData[3])
                        print("⭕️\(strIP)")
                        */
                    }
                })
            }
        } else {
            self.spinner.stopAnimating()
            self.enableConfirmBtn()
            print("取消配置...")
            self.cancel()
        }
    }
    
    /* 改变按钮状态 */
    func enableCancelBtn() {
        isConfirmState = false
        let title = NSLocalizedString("CONFIG_BUTTON_CANCEL", comment: "")
        confirmCancelBtn.setTitle(title, for: .normal)
    }
    func enableConfirmBtn() {
        isConfirmState = true
        let title = NSLocalizedString("CONFIG_BUTTON_CONFIRM", comment: "")
        confirmCancelBtn.setTitle(title, for: .normal)
    }
    
    /* 配置结果 */
    func executeForResult() -> ESPTouchResult {
        // 同步锁
        condition.lock()
        // 获得配置所需要的参数
        esptouchTask = ESPTouchTask(apSsid: SSID, andApBssid: BSSID, andApPwd: PASS)
        // 设置代理
        esptouchTask.setEsptouchDelegate(esptouchDelegate)
        condition.unlock()
        let esptouchResult: ESPTouchResult = self.esptouchTask.executeForResult()
        return esptouchResult
    }
    
    /* 取消配网 */
    func cancel() {
        condition.lock()
        if self.esptouchTask != nil {
            self.esptouchTask.interrupt()
        }
        condition.unlock()
    }
    
    
    /* 点击空白隐藏键盘 */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

class EspTouchDelegateImpl: NSObject, ESPTouchDelegate {
  
    @objc func dismissAlert(_ alertView: UIAlertView) {
        alertView.dismiss(withClickedButtonIndex: alertView.cancelButtonIndex, animated: true)
    }
    
    func showAlert(with result: ESPTouchResult) {
        let text = NSLocalizedString("WIFI_CONNECTION", comment: "")
        
        let message: String = result.bssid + text
        let dismissSeconds: TimeInterval = 3.5
        let alertView = UIAlertView(title: "", message: message, delegate: nil, cancelButtonTitle: nil)
        alertView.show()
        perform(#selector(self.dismissAlert), with: alertView, afterDelay: dismissSeconds)
    }
    
    func onEsptouchResultAdded(with result: ESPTouchResult) {
        print("EspTouchDelegateImpl onEsptouchResultAddedWithResult bssid: \(result.bssid)")
        // 放到主线程显示
        DispatchQueue.main.async(execute: {() -> Void in
            self.showAlert(with: result)
        })
    }
}
