//
//  NSData-AES.m
//  Encryption
//
//  Created by Jeff LaMarche on 2/12/09.
//  Copyright 2009 Jeff LaMarche Consulting. All rights reserved.
//

#import "NSData-AES.h"
#import "rijndael.h"

#import <CommonCrypto/CommonCryptor.h> 

@implementation NSData(AES)

- (NSData*)AES256EncryptWithKey:(NSString*)key {
    // 'key' should be 32 bytes for AES256, will be null-padded otherwise 
    char keyPtr[kCCKeySizeAES256 + 1]; // room for terminator (unused) 
    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding) 
    
    // fetch key data 
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding]; 
    
    NSUInteger dataLength = [self length]; 
    
    //See the doc: For block ciphers, the output size will always be less than or 
    //equal to the input size plus the size of one block. 
    //That's why we need to add the size of one block here 
    size_t bufferSize = dataLength + kCCBlockSizeAES128; 
    void* buffer = malloc(bufferSize); 
    
    size_t numBytesEncrypted = 0; 
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding, 
                                          keyPtr, kCCKeySizeAES256, 
                                          NULL /* initialization vector (optional) */, 
                                          [self bytes], dataLength, /* input */ 
                                          buffer, bufferSize, /* output */ 
                                          &numBytesEncrypted); 
    
    if (cryptStatus == kCCSuccess) 
    { 
        //the returned NSData takes ownership of the buffer and will free it on deallocation 
        return [NSMutableData dataWithBytesNoCopy:buffer length:numBytesEncrypted]; 
    } 
    
    free(buffer); //free the buffer; 
    return nil; 
} 

- (NSData *)AESEncryptWithPassphrase:(NSString *)pass
{
	NSMutableData *ret = [NSMutableData dataWithCapacity:[self length]];
	unsigned long rk[RKLENGTH(KEYBITS)];
	unsigned char key[KEYLENGTH(KEYBITS)];
	const char *password = [pass UTF8String];
	
	for (int i = 0; i < sizeof(key); i++)
		key[i] = password != 0 ? *password++ : 0;
	
	int nrounds = rijndaelSetupEncrypt(rk, key, KEYBITS);
	
	unsigned char *srcBytes = (unsigned char *)[self bytes];
	int index = 0;
	
	while (1) 
	{
		unsigned char plaintext[16];
		unsigned char ciphertext[16];
		int j;
		for (j = 0; j < sizeof(plaintext); j++)
		{
			if (index >= [self length])
				break;
			
			plaintext[j] = srcBytes[index++];
		}
		if (j == 0)
			break;
		for (; j < sizeof(plaintext); j++)
			plaintext[j] = ' ';
		
		rijndaelEncrypt(rk, nrounds, plaintext, ciphertext);
		[ret appendBytes:ciphertext length:sizeof(ciphertext)];
	}
	return ret;
}
- (NSData *)AESDecryptWithPassphrase:(NSString *)pass
{
	NSMutableData *ret = [NSMutableData dataWithCapacity:[self length]];
	unsigned long rk[RKLENGTH(KEYBITS)];
	unsigned char key[KEYLENGTH(KEYBITS)];
	const char *password = [pass UTF8String];
	for (int i = 0; i < sizeof(key); i++)
		key[i] = password != 0 ? *password++ : 0;

	int nrounds = rijndaelSetupDecrypt(rk, key, KEYBITS);
	unsigned char *srcBytes = (unsigned char *)[self bytes];
	int index = 0;
	while (index < [self length])
	{
		unsigned char plaintext[16];
		unsigned char ciphertext[16];
		int j;
		for (j = 0; j < sizeof(ciphertext); j++)
		{
			if (index >= [self length])
				break;
			
			ciphertext[j] = srcBytes[index++];
		}
		rijndaelDecrypt(rk, nrounds, ciphertext, plaintext);
		[ret appendBytes:plaintext length:sizeof(plaintext)];
		
	}
	return ret;
}
@end
