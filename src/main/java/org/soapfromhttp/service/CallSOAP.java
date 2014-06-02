/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.soapfromhttp.service;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.logging.Logger;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.soap.MessageFactory;
import javax.xml.soap.MimeHeaders;
import javax.xml.soap.SOAPBody;
import javax.xml.soap.SOAPConnection;
import javax.xml.soap.SOAPConnectionFactory;
import javax.xml.soap.SOAPConstants;
import javax.xml.soap.SOAPEnvelope;
import javax.xml.soap.SOAPException;
import javax.xml.soap.SOAPHeader;
import javax.xml.soap.SOAPMessage;
import org.apache.log4j.Level;
import org.soapfromhttp.log.MyLogger;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.xml.sax.SAXException;

/**
 *
 * @author bcivel
 */
@Service
public class CallSOAP {
  
    /**
     * Calcule d'une propriété depuis une requête SOAP.
     *
     * @param envelope
     * @param servicePath
     * @param method
     * @thorw CerberusException
     * @return String
     */
    public String calculatePropertyFromSOAPResponse(final String envelope, final String servicePath, final String method) {
        String result = null;
        ByteArrayOutputStream out = null;
        // Test des inputs nécessaires.
        if (envelope != null && servicePath != null && method != null) {
            
            SOAPConnectionFactory soapConnectionFactory;
            SOAPConnection soapConnection = null;
            try {
                soapConnectionFactory = SOAPConnectionFactory.newInstance();
                soapConnection = soapConnectionFactory.createConnection();
                MyLogger.log(CallSOAP.class.getName(), Level.INFO, "Connection opened");
                
                // Création de la requete SOAP
                MyLogger.log(CallSOAP.class.getName(), Level.INFO, "Create request");
                SOAPMessage input = createSOAPRequest(envelope, method);

                // Appel du WS
                MyLogger.log(CallSOAP.class.getName(), Level.INFO, "Calling WS");
                MyLogger.log(CallSOAP.class.getName(), Level.INFO, "Input :"+input);
                SOAPMessage soapResponse = soapConnection.call(input, servicePath);
                
                
                out = new ByteArrayOutputStream();

                soapResponse.writeTo(out);
                MyLogger.log(CallSOAP.class.getName(), Level.INFO, "WS response received");
                MyLogger.log(CallSOAP.class.getName(), Level.DEBUG, "WS response : "+out.toString());
                result = out.toString();


            } catch (SOAPException e){  
                MyLogger.log(CallSOAP.class.getName(), Level.ERROR, e.toString());
            } catch (IOException e) {
                MyLogger.log(CallSOAP.class.getName(), Level.ERROR, e.toString());
            } catch (ParserConfigurationException e) {
                MyLogger.log(CallSOAP.class.getName(), Level.ERROR, e.toString());
            } catch (SAXException e) {
                MyLogger.log(CallSOAP.class.getName(), Level.ERROR, e.toString());
            }
            finally{
                try {
                    if (soapConnection != null) {
                    soapConnection.close();
                    }
                    if (out != null) {
                    out.close();
                    }
                    MyLogger.log(CallSOAP.class.getName(), Level.INFO, "Connection and ByteArray closed");
                } catch (SOAPException ex) {
                    Logger.getLogger(CallSOAP.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
                } catch (IOException ex) {
                    Logger.getLogger(CallSOAP.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
                }
        }
        }
        return result;
    }

    /**
     * Contruction dynamique de la requête SOAP
     *
     * @param pBody
     * @param method
     * @return SOAPMessage
     * @throws SOAPException
     * @throws IOException
     * @throws SAXException
     * @throws ParserConfigurationException
     */
    private SOAPMessage createSOAPRequest(final String pBody, final String method) throws SOAPException, IOException, SAXException, ParserConfigurationException {

        // Précise la version du protocole SOAP à utiliser (nécessaire pour les appels de WS Externe)
        MessageFactory messageFactory = MessageFactory.newInstance(SOAPConstants.SOAP_1_2_PROTOCOL);

        SOAPMessage soapMessage = messageFactory.createMessage();

        MimeHeaders headers = soapMessage.getMimeHeaders();

        SOAPEnvelope sOAPEnvelope = soapMessage.getSOAPPart().getEnvelope();

        SOAPHeader sOAPHeader = sOAPEnvelope.addHeader();
        sOAPHeader.addChildElement("xmlns", "ns", "http://RedouteFrance/Sell/ShoppingCart/2.0/SaveOrder/1.0");

        // Précise la méthode du WSDL à interroger
        headers.addHeader("SOAPAction", method);
        // Encodage UTF-8
        headers.addHeader("Content-Type", "text/xml;charset=UTF-8");

        final SOAPBody soapBody = soapMessage.getSOAPBody();

        // convert String into InputStream - traitement des caracères escapés > < ... (contraintes de l'affichage IHM)
        //InputStream is = new ByteArrayInputStream(HtmlUtils.htmlUnescape(pBody).getBytes());
        InputStream is = new ByteArrayInputStream(pBody.getBytes());
        DocumentBuilder builder = null;

        DocumentBuilderFactory builderFactory = DocumentBuilderFactory.newInstance();
        
        // Important à laisser sinon KO
        builderFactory.setNamespaceAware(true);
        try {
            builder = builderFactory.newDocumentBuilder();

            Document document = builder.parse(is);

            soapBody.addDocument(document);
        } catch (ParserConfigurationException e) {
            MyLogger.log(CallSOAP.class.getName(), Level.ERROR, e.toString());
        } finally{
            is.close();
        if (builder != null) {
            builder.reset();
        }
        }
        soapMessage.saveChanges();

        return soapMessage;
    }
}
