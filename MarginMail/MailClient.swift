//
//  MailClient.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/17/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

class MailClient {

    var onUpdate: (Void -> Void)?

    private var address: MailAddress
    private var reader: MailReader?
    private var writer: MailWriter?

    private var _folders: [MailFolder] = []
    var folders: [MailFolder] {
        return _folders
    }

    private var _messages: [MailFolder: [MailMessage]] = [:]
    var messages: [MailFolder: [MailMessage]] {
        return _messages
    }

    private var _syncing = false
    var syncing: Bool {
        return _syncing
    }

    private var _updated: NSDate? = nil
    var updated: NSDate? {
        return _updated
    }

    init(address: MailAddress, reader: MailReader?, writer: MailWriter?) {
        self.address = address
        self.reader = reader
        self.writer = writer
    }

    convenience init(account: Account) {
        self.init(
            address: account.address,
            reader: account.incoming?.createReader(),
            writer: account.outgoing?.createWriter()
        )
    }

    func sync() {
        Lock.with(self) {
            if let reader = reader {
                if _syncing {
                    return
                }
                _syncing = true
                Dispatch.queue(.BACKGROUND) {
                    self._sync(reader) {
                        self._syncing = false
                    }
                }
            }
        }
    }

    private func _sync(reader: MailReader, callback: Void -> Void) {
        reader.getAllFolders() { folders in
            self._folders = folders
            self.onUpdate?()
            for folder in folders {
                reader.getMessagesInFolder(folder) { messages in
                    self._messages[folder] = messages
                    self.onUpdate?()
                }
            }
        }
    }

}
