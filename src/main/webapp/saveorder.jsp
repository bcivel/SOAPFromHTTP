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
        
        String envelope2 = "<ns:SaveOrderRequest_1.0><Header><Application>VC-CRM-RFR</Application><Channel>LocalTelephone</Channel><UserId type=\"OperatorNumber\">99090</UserId><UserPlaceId>03123</UserPlaceId><UserDisplayLanguage>fr</UserDisplayLanguage><UserDisplayCountry>FR</UserDisplayCountry><Environment>Test</Environment><Timestamp>##DATE_JOUR##</Timestamp><TokenId>2be6b232866f6298d255360a07c8</TokenId></Header><Request><PreOrder><IsClickToCall>false</IsClickToCall></PreOrder><IsVATDetailRequested>false</IsVATDetailRequested><Cart><Customers><Customer type=\"Charged\"><CustomerId>10001641</CustomerId><Person><Birth>1952-04-03</Birth><BirthCityName/></Person></Customer></Customers><Coupons><Coupon><CommercialOfferID> </CommercialOfferID><IsCouponRefusedByCustomer>false</IsCouponRefusedByCustomer><IsGiftItemRemovedByCustomer>false</IsGiftItemRemovedByCustomer><NumberOfTries>1</NumberOfTries></Coupon></Coupons><LineItems><LineItem><LineItemId>1</LineItemId><Quantity>1.0</Quantity><CustomizationText/><ItemOffer><OfferId>17168025</OfferId><OfferType>Article</OfferType><Availability><StockStatus>Available</StockStatus><StockStatusDelay>P0M</StockStatusDelay></Availability><Prices><Price type=\"CatalogPrice\"><PriceValue>10.43</PriceValue></Price></Prices><Fees><Fee type=\"WEEE\"><FeeValue>0.0</FeeValue></Fee></Fees></ItemOffer><ItemCoupon> <CommercialOfferID>0</CommercialOfferID><Discount type=\"Discount\"><DiscountAmount>0.0</DiscountAmount><DiscountPercentage>0.0</DiscountPercentage><IsFreeDisplayedWhen100>true</IsFreeDisplayedWhen100></Discount></ItemCoupon><Deliveries><Delivery><DeliveryPeriod><FromDate>##DATE_LIVRAISON##</FromDate></DeliveryPeriod><DeliveryId>29</DeliveryId></Delivery></Deliveries><TotalAmounts><TotalAmount type=\"NetPrice\"><Amount>10.43</Amount></TotalAmount></TotalAmounts></LineItem><LineItem><LineItemId>2</LineItemId><Quantity>1.0</Quantity><CustomizationText/><ItemOffer><OfferId>14659502</OfferId><OfferType>Article</OfferType><Availability><StockStatus>Available</StockStatus><StockStatusDelay>P0M</StockStatusDelay></Availability><Prices><Price type=\"CatalogPrice\"><PriceValue>19.9</PriceValue></Price></Prices><Fees><Fee type=\"WEEE\"><FeeValue>0.0</FeeValue></Fee></Fees></ItemOffer><ItemCoupon><CommercialOfferID>0</CommercialOfferID><Discount type=\"Discount\"><DiscountAmount>0.0</DiscountAmount><DiscountPercentage>0.0</DiscountPercentage><IsFreeDisplayedWhen100>true</IsFreeDisplayedWhen100></Discount></ItemCoupon><Deliveries><Delivery><DeliveryPeriod><FromDate>##DATE_LIVRAISON##</FromDate></DeliveryPeriod><DeliveryId>29</DeliveryId></Delivery></Deliveries><TotalAmounts><TotalAmount type=\"NetPrice\"><Amount>19.9</Amount></TotalAmount></TotalAmounts></LineItem><LineItem><LineItemId>3</LineItemId><Quantity>1.0</Quantity><CustomizationText/><ItemOffer><OfferId>15923640</OfferId><OfferType>Article</OfferType><Availability><StockStatus>Available</StockStatus><StockStatusDelay>P0M</StockStatusDelay></Availability><Prices><Price type=\"CatalogPrice\"><PriceValue>14.97</PriceValue></Price></Prices><Fees><Fee type=\"WEEE\"><FeeValue>0.0</FeeValue></Fee></Fees></ItemOffer><ItemCoupon><CommercialOfferID>0</CommercialOfferID><Discount type=\"Discount\"><DiscountAmount>0.0</DiscountAmount><DiscountPercentage>0.0</DiscountPercentage><IsFreeDisplayedWhen100>true</IsFreeDisplayedWhen100></Discount></ItemCoupon><Deliveries><Delivery><DeliveryPeriod><FromDate>##DATE_LIVRAISON##</FromDate></DeliveryPeriod><DeliveryId>29</DeliveryId></Delivery></Deliveries><TotalAmounts><TotalAmount type=\"NetPrice\"><Amount>14.97</Amount></TotalAmount></TotalAmounts></LineItem></LineItems><Deliveries><Delivery><DeliveryMode>Place</DeliveryMode><DeliveryPlace><DeliveryPlaceId>O2064</DeliveryPlaceId><DeliveryPlaceType>RelaisColis</DeliveryPlaceType></DeliveryPlace><DeliveryId>29</DeliveryId></Delivery><Delivery><DeliveryMode>Address</DeliveryMode><DeliveryAddress type=\"Home\"><AddressId>0520141250015212</AddressId><HasElevator>false</HasElevator></DeliveryAddress></Delivery></Deliveries><Payments><Payment><PaymentMode>CashOnDelivery</PaymentMode><PaymentAmount>54.15</PaymentAmount></Payment></Payments><Fees><Fee type=\"Payment\"><FeeValue>2.9</FeeValue></Fee><Fee type=\"Delivery\"><FeeValue>0.0</FeeValue></Fee><Fee type=\"Environmental\"><FeeValue>0.0</FeeValue></Fee></Fees><TotalAmounts><TotalAmount type=\"Discount\"><Amount>0.0</Amount></TotalAmount><TotalAmount type=\"WEEE\"><Amount>0.0</Amount></TotalAmount><TotalAmount type=\"TaxRefund\"><Amount>0.0</Amount></TotalAmount><TotalAmount type=\"Service\"><Amount>0.0</Amount></TotalAmount><TotalAmount type=\"TotalAmount\"><Amount>54.15</Amount></TotalAmount><TotalAmount type=\"Due\"><Amount>54.15</Amount></TotalAmount></TotalAmounts></Cart></Request></ns:SaveOrderRequest_1.0>";
        
        Calendar calendar=Calendar.getInstance();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat hourFormat = new SimpleDateFormat("H:m:00.000 Z");

        String envelope = envelope2.replaceAll("##DATE_JOUR##",dateFormat.format(calendar.getTime())+"T"+hourFormat.format(calendar.getTime()));
        calendar.add(Calendar.DATE, 7);
        envelope2 = envelope;
        envelope = envelope2.replaceAll("##DATE_LIVRAISON##",dateFormat.format(calendar.getTime())+"T"+hourFormat.format(calendar.getTime()));
        String servicePath = "http://re7fonc.servicespms.siege.red/RedouteFrance/Sell/ShoppingCart/2.0?wsdl";
//        String servicePath = request.getParameter("servicePath");
        String method = "SaveOrder_1.0";
//       String method = request.getParameter("method");
        
        
        MyLogger.log(CallSOAP.class.getName(), Level.DEBUG, envelope + "|||" + envelope.length());

        String result;
        try {
            result = soapCall.calculatePropertyFromSOAPResponse(envelope, servicePath, method);
        }
        catch(Exception ex) {
            ex.printStackTrace();
            out.println("servicePath");
            out.println(servicePath);
            out.println("method");
            out.println(method);
            out.println("envelope");
            out.println(envelope);
            result = "ERROR";
        }
        catch (Throwable t) {
            result = "ERROR";
            t.printStackTrace();
            out.println("servicePath");
            out.println(servicePath);
            out.println("method");
            out.println(method);
            out.println("envelope");
            out.println(envelope);
        }
        MyLogger.log(CallSOAP.class.getName(), Level.DEBUG, result);
        %>
        <%=result%>
     