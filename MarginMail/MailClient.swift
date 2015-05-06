//
//  MailClient.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/17/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

protocol MailDelegate {

//    func mailSyncEventDid

}

class MailClient {

    enum Mode {
        case ACTIVE
        case PASSIVE
    }

    enum State {
        case WAITING
        case SYNCING
    }

    var delegate: MailDelegate?

    var mode: Mode = .PASSIVE

    private var address: MailAddress
    private var reader: MailReader?
    private var writer: MailWriter?

    private var _folders: [MailFolder] = []
    var folders: [MailFolder] {
        return _folders
    }

    private var _state: State = .WAITING
    var state: State {
        return _state
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
            if state == .SYNCING { return }
            _state = .SYNCING
            Dispatch.queue(.BACKGROUND, block: sync_start)
        }
    }

    private func sync_start() {
        if let reader = self.reader {
            sync_folders(reader)
        } else {
            sync_finish()
        }
    }

    private func sync_finish() {
        _state = .WAITING
    }

    private func sync_folders(reader: MailReader) {
        reader.getAllFolders() { folders in
            self._folders = folders
            self.sync_messages(reader, folders: folders)
        }
    }

    private func sync_messages(reader: MailReader, folders: [MailFolder]) {
        for folder in folders {
            println(folder)
        }
    }

    private func sync_folders(folders: [MailFolder]) {
        sync_finish()
    }

}
