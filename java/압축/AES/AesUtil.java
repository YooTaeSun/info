package zTestWeb.aes;

import java.security.SecureRandom;
import java.security.spec.KeySpec;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.codec.binary.Hex;

public class AesUtil {
/*
	- keySize : AES128 의 128을 의미한다.
	- iterationCount : 암호화 관련키(PEBKey)을 생성하는 횟수를 의미한다. 10000 번은 기본값에 해당되고 횟수가 높을수록 암호화 강도가 강하다고 한다.
	- salt : 해시값의 무작위성을 높이기 위한 보조키에 해당한다. 실제로 해시값에 소금을 친다(Adding Salt)는 표현을 쓴다.
	- iv : AES암호화를 위한 메인키라고 볼 수 있다.

	현재 salt값과 iv값은 정적변수(static)로 되어 있지만 실제 사용시에는 그때그때 생성해서 사용해도 된다.
	salt는 32자리의 헥스값, iv는 16자리의 헥스값을 만들면 된다.

	아래처럼 랜덤 헥스값을 만드는 메서드 getRandomHexString 를 사용하면 된다.
	
	salt = getRandomHexString(32);
	iv = getRandomHexString(16);
*/	
	
    private static final int keySize = 128;
    private static final int iterationCount = 10000;
    private static String salt = "79752f1d3fd2432043c48e45b35b24645eb826a25c6f1804e9152665c345a552";
    private static String iv = "2fad5a477d13ecda7f718fbd8a9f0443";
    private static final String passPhrase = "passPhrase";
    
    private final Cipher cipher;
    
    
    public AesUtil() {
        try {
            cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    
    public String encrypt(String plaintext) throws Exception {
        return encrypt(salt, iv, passPhrase, plaintext);
    }
    
    
    public String decrypt(String ciphertext) throws Exception {
        return decrypt(salt, iv, passPhrase, ciphertext);
    }
    
    
    private String encrypt(String salt, String iv, String passPhrase, String plaintext) throws Exception {
        SecretKey key = generateKey(salt, passPhrase);
        byte[] encrypted = doFinal(Cipher.ENCRYPT_MODE, key, iv, plaintext.getBytes("UTF-8"));
        return encodeBase64(encrypted);
    }

    
    private String decrypt(String salt, String iv, String passPhrase, String ciphertext) throws Exception {
        SecretKey key = generateKey(salt, passPhrase);
        byte[] decrypted = doFinal(Cipher.DECRYPT_MODE, key, iv, decodeBase64(ciphertext));
        return new String(decrypted, "UTF-8");
    }

    
    private byte[] doFinal(int encryptMode, SecretKey key, String iv, byte[] bytes) throws Exception {
        cipher.init(encryptMode, key, new IvParameterSpec(decodeHex(iv)));
        return cipher.doFinal(bytes);
    }

    
    private SecretKey generateKey(String salt, String passPhrase) throws Exception {
        SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
        KeySpec spec = new PBEKeySpec(passPhrase.toCharArray(), decodeHex(salt), iterationCount, keySize);
        SecretKey key = new SecretKeySpec(factory.generateSecret(spec).getEncoded(), "AES");
        return key;
    }
    
    
    private static String encodeBase64(byte[] bytes) {
        return Base64.encodeBase64String(bytes);
    }

    
    private static byte[] decodeBase64(String str) {
        return Base64.decodeBase64(str);
    }

    
    private static String encodeHex(byte[] bytes) {
        return Hex.encodeHexString(bytes);
    }

    
    private static byte[] decodeHex(String str) throws Exception {
        return Hex.decodeHex(str.toCharArray());
    }
    
    
    private static String getRandomHexString(int length) {
        byte[] salt = new byte[length];
        new SecureRandom().nextBytes(salt);
        return encodeHex(salt);

    }
    
    public static void main(String[] args) {
    	
    	System.out.println("hex >> " + getRandomHexString(16)); 
    	System.out.println("hex >> " + getRandomHexString(16)); 
    	System.out.println("hex >> " + getRandomHexString(16)); 
    	System.out.println("hex >> " + getRandomHexString(16)); 
    	System.out.println("hex >> " + getRandomHexString(16)); 
    	System.out.println("hex >> " + getRandomHexString(16)); 
    	
        try {
            AesUtil aesUtil = new AesUtil();
            
            String encString = aesUtil.encrypt("pass1234");
            System.out.println("encString : " + encString);
            
            String decString = aesUtil.decrypt(encString);
            System.out.println("decString : " + decString);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


}

