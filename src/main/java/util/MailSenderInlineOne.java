package util;

import java.io.File;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

public class MailSenderInlineOne {

	public static void sendMailWithInlineImage(String to, String subject, String bodyText, File imageFile)
			throws Exception {
		String host = "smtp.gmail.com";
		String username = "kosta2025001@gmail.com"; // Gmail 계정
		String password = "dbxa oxrx ibky rxve"; // 앱 비밀번호

		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", "587");

		Session session = Session.getInstance(props, new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		});
		session.setDebug(true);
		Message message = new MimeMessage(session);
		message.setFrom(new InternetAddress(username, "브랜드 어드민"));
		message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
		message.setSubject(subject);

		// HTML 본문 + inline 이미지
		MimeBodyPart htmlPart = new MimeBodyPart();
		String htmlContent = "<p>" + bodyText + "</p>" + "<img src=\"cid:mainImage\" style=\"max-width:600px;\">";
		htmlPart.setContent(htmlContent, "text/html; charset=UTF-8");

		MimeBodyPart imagePart = new MimeBodyPart();
		imagePart.attachFile(imageFile);
		imagePart.setContentID("<mainImage>");
		imagePart.setDisposition(MimeBodyPart.INLINE);

		MimeMultipart multipart = new MimeMultipart("related");
		multipart.addBodyPart(htmlPart);
		multipart.addBodyPart(imagePart);

		message.setContent(multipart);

		Transport.send(message);
	}
}
