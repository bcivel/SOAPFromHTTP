<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="org.soapfromhttp.log.MyLogger"%>
<%@page import="org.apache.log4j.Level"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page import="org.soapfromhttp.service.CallSOAP"%>


        <%
        ApplicationContext appContext = WebApplicationContextUtils.getWebApplicationContext(this.getServletContext());
        CallSOAP soapCall = appContext.getBean(CallSOAP.class);
        
        String offerid=request.getParameter("offerid");
        String amount=request.getParameter("amount");
        
        if(offerid == null || "".equals(offerid.trim())) {
            offerid="20227039";
        }
        
        if(amount == null || "".equals(amount.trim())) {
            amount="14.99";
        }

//        String envelope2 = "<SaveOrderRequest_1.0 xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns=\"http://RedouteFrance/Sell/ShoppingCart/2.0/SaveOrder/1.0\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"><Header xmlns=\"\"><Site>www.laredoute.fr</Site><Channel>Web</Channel><UserPlaceId>00000</UserPlaceId><UserDisplayLanguage>FR</UserDisplayLanguage><UserDisplayCountry>FR</UserDisplayCountry><UserIPAddress>195.115.152.114</UserIPAddress><Environment></Environment><Timestamp>##DATE_JOUR##</Timestamp><TokenId>0c8007ee-f900-4125-9003-b674af303121</TokenId></Header><Request xmlns=\"\"><Cart><Customers><Customer type=\"Charged\"><CustomerId>565042475</CustomerId></Customer></Customers><Coupons><Coupon><CommercialOfferID>    </CommercialOfferID><IsCouponRefusedByCustomer>false</IsCouponRefusedByCustomer><IsGiftItemRemovedByCustomer>false</IsGiftItemRemovedByCustomer><NumberOfTries>1</NumberOfTries></Coupon></Coupons><LineItems><LineItem><LineItemId>01</LineItemId><RelativeLineItemID>00</RelativeLineItemID><DisplayRank>1</DisplayRank><Quantity>1.0</Quantity><CustomizationText/><ItemOffer><OfferId>16415246</OfferId><Availability><StockStatus>Available</StockStatus></Availability><Prices><Price type=\"CatalogPrice\"><PriceValue>89.00</PriceValue></Price></Prices><Fees><Fee type=\"WEEE\"><FeeValue>0.0</FeeValue></Fee></Fees><Services><Service/></Services></ItemOffer><ItemCoupon><CommercialOfferID>0</CommercialOfferID><Discount/></ItemCoupon><Deliveries><Delivery><DeliveryPeriod><FromDate>##DATE_LIVRAISON##</FromDate></DeliveryPeriod><DeliveryId>29</DeliveryId></Delivery></Deliveries><TotalAmounts><TotalAmount type=\"CatalogPrice\"><Amount>59.99</Amount></TotalAmount></TotalAmounts></LineItem></LineItems><Deliveries><Delivery><DeliveryMode>Place</DeliveryMode><DeliveryPlace><DeliveryPlaceId>Z9004</DeliveryPlaceId></DeliveryPlace><DeliveryId>29</DeliveryId><LineItems><LineItemId xsi:type=\"xsd:string\">1</LineItemId></LineItems></Delivery><Delivery><DeliveryMode>Address</DeliveryMode><DeliveryAddress type=\"Home\"><AddressId>0520140430000080</AddressId><HasElevator>false</HasElevator></DeliveryAddress></Delivery></Deliveries><Payments><Payment><PaymentMode>PaymentCard</PaymentMode><Aliases><Alias><PaymentAliasID>565042475_00112</PaymentAliasID><IsTemporary>true</IsTemporary><PaymentCard><MaskNumber>XXXXXXXXXXXX1111</MaskNumber><PaymentCardBrand>VISA</PaymentCardBrand><HolderFullname>Jean Dupont</HolderFullname><ValidityDates><ToMonth>2017-12</ToMonth></ValidityDates></PaymentCard><AliasAmount>89.00</AliasAmount></Alias></Aliases></Payment></Payments><TotalAmounts><TotalAmount type=\"TotalAmount\"><Amount>89.00</Amount></TotalAmount><TotalAmount type=\"Discount\"><Amount>0.0</Amount></TotalAmount><TotalAmount type=\"OrderDiscount\"><Amount>0.0</Amount></TotalAmount><TotalAmount type=\"WEEE\"><Amount>0.0</Amount></TotalAmount><TotalAmount type=\"Service\"><Amount>0.0</Amount></TotalAmount><TotalAmount type=\"CatalogRefund\"><Amount>0.0</Amount></TotalAmount><TotalAmount type=\"Due\"><Amount>89.00</Amount></TotalAmount><TotalAmount type=\"Payment\"><Amount>0.0</Amount></TotalAmount></TotalAmounts></Cart></Request></SaveOrderRequest_1.0>";
        String envelope2 = "<SaveOrderRequest_1.0 xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns=\"http://RedouteFrance/Sell/ShoppingCart/2.0/SaveOrder/1.0\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"><Header xmlns=\"\"><Site>www.laredoute.fr</Site><Channel>Web</Channel><UserPlaceId>00000</UserPlaceId><UserDisplayLanguage>FR</UserDisplayLanguage><UserDisplayCountry>FR</UserDisplayCountry><UserIPAddress>195.115.152.114</UserIPAddress><Environment>Test</Environment><Timestamp>##DATE_JOUR##</Timestamp><TokenId>0c8007ee-f900-4125-9003-b674af303121</TokenId></Header><Request xmlns=\"\"><Cart><Customers><Customer type=\"Charged\"><CustomerId>565042475</CustomerId></Customer></Customers><Coupons><Coupon><CommercialOfferID>    </CommercialOfferID><IsCouponRefusedByCustomer>false</IsCouponRefusedByCustomer><IsGiftItemRemovedByCustomer>false</IsGiftItemRemovedByCustomer><NumberOfTries>1</NumberOfTries></Coupon></Coupons><LineItems><LineItem><LineItemId>01</LineItemId><RelativeLineItemID>00</RelativeLineItemID><DisplayRank>1</DisplayRank><Quantity>1.0</Quantity><CustomizationText/><ItemOffer><OfferId>##OFFERID##</OfferId><Availability><StockStatus>Available</StockStatus></Availability><Prices><Price type=\"CatalogPrice\"><PriceValue>##AMOUNT##</PriceValue></Price></Prices><Fees><Fee type=\"WEEE\"><FeeValue>0.0</FeeValue></Fee></Fees><Services><Service/></Services></ItemOffer><ItemCoupon><CommercialOfferID>0</CommercialOfferID><Discount/></ItemCoupon><Deliveries><Delivery><DeliveryPeriod><FromDate>##DATE_LIVRAISON##</FromDate></DeliveryPeriod><DeliveryId>29</DeliveryId></Delivery></Deliveries><TotalAmounts><TotalAmount type=\"CatalogPrice\"><Amount>##AMOUNT##</Amount></TotalAmount></TotalAmounts></LineItem></LineItems><Deliveries><Delivery><DeliveryMode>Place</DeliveryMode><DeliveryPlace><DeliveryPlaceId>Z9004</DeliveryPlaceId></DeliveryPlace><DeliveryId>29</DeliveryId><LineItems><LineItemId xsi:type=\"xsd:string\">1</LineItemId></LineItems></Delivery><Delivery><DeliveryMode>Address</DeliveryMode><DeliveryAddress type=\"Home\"><AddressId>0520140430000080</AddressId><HasElevator>false</HasElevator></DeliveryAddress></Delivery></Deliveries><Payments><Payment><PaymentMode>PaymentCard</PaymentMode><Aliases><Alias><PaymentAliasID>565042475_00112</PaymentAliasID><IsTemporary>true</IsTemporary><PaymentCard><MaskNumber>XXXXXXXXXXXX1111</MaskNumber><PaymentCardBrand>VISA</PaymentCardBrand><HolderFullname>Jean Dupont</HolderFullname><ValidityDates><ToMonth>2017-12</ToMonth></ValidityDates></PaymentCard><AliasAmount>##AMOUNT##</AliasAmount></Alias></Aliases></Payment></Payments><TotalAmounts><TotalAmount type=\"TotalAmount\"><Amount>##AMOUNT##</Amount></TotalAmount><TotalAmount type=\"Discount\"><Amount>0.0</Amount></TotalAmount><TotalAmount type=\"OrderDiscount\"><Amount>0.0</Amount></TotalAmount><TotalAmount type=\"WEEE\"><Amount>0.0</Amount></TotalAmount><TotalAmount type=\"Service\"><Amount>0.0</Amount></TotalAmount><TotalAmount type=\"CatalogRefund\"><Amount>0.0</Amount></TotalAmount><TotalAmount type=\"Due\"><Amount>##AMOUNT##</Amount></TotalAmount><TotalAmount type=\"Payment\"><Amount>0.0</Amount></TotalAmount></TotalAmounts></Cart></Request></SaveOrderRequest_1.0>";
        
        Calendar calendar=Calendar.getInstance();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat hourFormat = new SimpleDateFormat("HH:mm");

        String envelope = envelope2.replaceAll("##DATE_JOUR##",dateFormat.format(calendar.getTime())+"T"+hourFormat.format(calendar.getTime())+":01.452+02:00");
        calendar.add(Calendar.DATE, 2);
        envelope2 = envelope;
        envelope = envelope2.replaceAll("##DATE_LIVRAISON##",dateFormat.format(calendar.getTime())+"T"+hourFormat.format(calendar.getTime())+":01");
        String servicePath = "http://re7fonc.servicespms.siege.red/RedouteFrance/Sell/ShoppingCart/2.0?wsdl";
        String method = "SaveOrder_1.0";
        
        envelope2 = envelope.replaceAll("##OFFERID##", offerid);
        envelope = envelope2.replaceAll("##AMOUNT##", amount);
        
        MyLogger.log(CallSOAP.class.getName(), Level.DEBUG, envelope + "|||" + envelope.length());

        String result = "";
        try {
            result = soapCall.calculatePropertyFromSOAPResponse(envelope, servicePath, method);
            if(result == null) {
                result = "ERROR"+envelope;
            }
        }
        catch(Exception ex) {
            result = "ERROR";
            ex.printStackTrace();
        }
        catch (Throwable t) {
            result = "ERROR";
            t.printStackTrace();
        } finally {
        }
        MyLogger.log(CallSOAP.class.getName(), Level.DEBUG, result);
        %>
        <%=result%>
     