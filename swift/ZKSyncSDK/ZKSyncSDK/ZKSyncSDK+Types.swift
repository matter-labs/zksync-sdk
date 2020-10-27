//
//  ZKSyncSDK+Types.swift
//  ZKSyncSDK-UI
//
//  Made with ❤️ by Matter Labs on 10/23/20
//

import Foundation

public class ZKCryptoData {
    class var bytesLength: Int {
        return 0
    }
    
    private var content: Data
    
    init(_ content: Data) {
        assert(content.count == Self.bytesLength, "Incorrect data length. Should be \(Self.bytesLength)")

        self.content = content
    }
    
    convenience init(_ content: [UInt8]) {
        self.init(Data(content))
    }
    
    public func data() -> Data {
        return content
    }
    
    public func base64String() -> String {
        return content.base64EncodedString()
    }
    
    public func hexEncodedString() -> String {
        return content.map { String(format: "%02hhX", $0) }.joined()
    }
    
    func withUnsafeBytes<ResultType>(_ body: (UnsafeRawBufferPointer) throws -> ResultType) rethrows -> ResultType {
        return try! content.withUnsafeBytes(body)
    }
}

public class ZKPackedPublicKey: ZKCryptoData {
    override class var bytesLength: Int {
        return 32
    }
}

public class ZKPrivateKey: ZKCryptoData {
    override class var bytesLength: Int {
        return 32
    }
}

public class ZKPublicHash: ZKCryptoData {
    override class var bytesLength: Int {
        return 20
    }
}

public class ZKSignature: ZKCryptoData {
    override class var bytesLength: Int {
        return 64
    }
}


public enum ZKSyncSDKError: Error {
    case musigTooLongError
    case seedTooShortError
    case unsupportedOperation
}

public enum ZKSyncSDKResult<T> {
    case success(_ result: T)
    case error(_ error: Error)
}


typealias CLibZksPrivateKey = ZksPrivateKey
typealias CLibZksPackedPublicKey = ZksPackedPublicKey
typealias CLibZksPubkeyHash = ZksPubkeyHash
typealias CLibZksSignature = ZksSignature

