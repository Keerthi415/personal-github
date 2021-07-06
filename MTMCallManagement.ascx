<%@ control language="C#" autoeventwireup="true" inherits="ClaimsManagement_UserControls_MTMCallManagement, App_Web_mtmcallmanagement.ascx.e6e6da4" %>
<style type="text/css">
    .AgadiaButton1
    {
        border: 0 !important;
        margin-left: 6px;
        background: none !important;
    }
    .AgadiaButton1:hover
    {
        border: 0 !important;
        margin-left: 6px;
        background: none !important;
        box-shadow: none;
    }
    .AgadiaButton1 input
    {
        border: 1px solid #3DB8FA !important;
        background-color: #3DB8FA !important;
        color: white !important;
        padding: 1px 1px 1px 1px !important;
        font: Helvetica, Arial, sans-serif !important;
        vertical-align: top !important;
        font-size: 11px !important;
        height: 23px !important;
        cursor: pointer !important;
        width: 90px !important;
    }
    
    .ulList
    {
        margin: 5px 1px 5px 3px;
        padding: 0px;
        list-style-type: disc !important;
        list-style-position: inside !important;
        text-align: left !important;
    }
    .ulList li
    {
        margin: 1px 1px 1px 3px;
        padding: 0px;
        text-align: left !important;
    }
    .CustomizedrwPopupButton
    {
        background-color: #3DB8FA !important;
        border: 1px #3DB8FA;
        color: white !important;
        width: 80px;
    }
    
    .CustomizedrwPopupButton:hover
    {
        border: 1px solid #3DB8FA !important;
        background: white !important;
        text-decoration: none;
        color: #3DB8FA !important;
    }
    .RadWindow_Metro table.rwTitlebarControls em
    {
        text-transform: none;
    }
</style>
<telerik:RadScriptBlock ID="RadCodeBlock1" runat="server">
    <script type="text/javascript">
        //Prevent page on Enter key Defect#16901
        window.onkeydown=toRestrictKeyEnter;
        function toRestrictKeyEnter(){
            if (event.keyCode == 13 && event.srcElement.type != 'textarea')
                return false;
            return true;
        }
        function CancelPopUpCMRTMRDeleteRedirect() {
            var oWnd = $find("<%= RadWindowForThrbtnDelete.ClientID %>");
            oWnd.Close();
            // document.location.reload(true)
            window.parent.location = window.parent.location.href;
            return false;
            //document.getElementById('<%=btnRefreshTriage.ClientID%>').click();
        }
        var itemindexForTMRDelete;
        function ConfirmDeleteForTMR(btn, index) {
            var cmrprivTMR = document.getElementById("<%= hdnInProgressPrivlgTmr.ClientID %>");
            if (cmrprivTMR.value == "1") {
                radalert("You do not have the privilege to delete an In Progress TMR.", 375, 100, "MTM");
                return false;
            }
            else {
                itemindexForTMRDelete = index;
                var windTmr = radconfirm("Are you sure you want to delete the TMR In Progress?", confirmCallBackFnForDeleteTMRPopup, 350, 100, null, "WARNING");
                windTmr._titleIconElement.style.background = "url('../CSS/AgadiaBlue/Images/warning.png') no-repeat";
                windTmr.set_behaviors(Telerik.Web.UI.WindowBehaviors.None);
                return false;
            }

        }

        function confirmCallBackFnForDeleteTMRPopup(arg) {
            if (arg) {
                $find("<%=raddeleteForCMRTMR.ClientID %>").show();
                var txtReasonForDeleteCMRTMR = document.getElementById("<%=txtReasonForDeleteCMRTMR.ClientID%>");
                txtReasonForDeleteCMRTMR.value = '';
                var messageSpan = document.getElementById("<%=spnForDelete.ClientID%>");
                messageSpan.innerText = '';
                var txt = document.getElementById("<%=spanTxtForModule.ClientID%>");
                txt.innerText = 'Enter the reason for deleting this In Progress TMR:';
            }
        }

        function confirmCallBackFnForDeleteTMR(arg) {
            if (arg) {
                var masterTable = $find("<%= TMRGrid.ClientID %>").get_masterTableView();
                masterTable.fireCommand("DeleteLink", itemindexForTMRDelete);

            }
        }
        var itemindexForCMRDelete;
        function ConfirmDeleteForCMR(btn, index) {
            var cmrpriv = document.getElementById("<%= hdnInProgressPrivlgCmr.ClientID %>");
            if (cmrpriv.value == "1") {
                radalert("You do not have the privilege to delete an In Progress CMR.", 380, 100, "MTM");
                return false;
            }
            else {
                itemindexForCMRDelete = index;
                var windCmr = radconfirm("Are you sure you want to delete the CMR In Progress?", confirmCallBackFnForDeleteCMRPopoup, 350, 100, null, "WARNING");
                windCmr._titleIconElement.style.background = "url('../CSS/AgadiaBlue/Images/warning.png') no-repeat";
                windCmr.set_behaviors(Telerik.Web.UI.WindowBehaviors.None);
                return false;
            }

        }
        function confirmCallBackFnForDeleteCMRPopoup(arg) {
            if (arg) {
                $find("<%=raddeleteForCMRTMR.ClientID %>").show();
                var txtReasonForDeleteCMRTMR = document.getElementById("<%=txtReasonForDeleteCMRTMR.ClientID%>");
                txtReasonForDeleteCMRTMR.value = '';
                var messageSpan = document.getElementById("<%=spnForDelete.ClientID%>");
                messageSpan.innerText = '';
                var txt = document.getElementById("<%=spanTxtForModule.ClientID%>");
                txt.innerText = 'Enter the reason for deleting this In Progress CMR:';
            }
        }
        function limitText(limitField, limitNum) {
            if (limitField.value.length > limitNum) {
                limitField.value = limitField.value.substring(0, limitNum);
            }
        }

        function OnSaveClickForDelete() {

            var txtReasonForDeleteCMRTMR = document.getElementById("<%=txtReasonForDeleteCMRTMR.ClientID%>");
            if (txtReasonForDeleteCMRTMR.innerText == "") {
                var messageSpan = document.getElementById("<%=spnForDelete.ClientID%>");
                messageSpan.style.display = "inline";
                messageSpan.innerText = 'Reason is required.';

            }
            else {

                if (itemindexForTMRDelete != undefined) {
                    var masterTable = $find("<%= TMRGrid.ClientID %>").get_masterTableView();
                    masterTable.fireCommand("DeleteLink", itemindexForTMRDelete);
                }
                else if (itemindexForCMRDelete != undefined) {
                    var masterTable = $find("<%= CMRGrid.ClientID %>").get_masterTableView();
                    masterTable.fireCommand("DeleteLink", itemindexForCMRDelete);
                }

            }

        }

        function RedirectToHome() {
            var url = window.location.href;
            var n = url.lastIndexOf("/");

            url = url.substring(0, n + 1) + "HomePage.aspx<%=QueryStringTokenWithQuestionMark%>";
            window.parent.location = url;
        }


        function ListView_ShowBIMSAssessments(event, obj, nonAdhererId) {
            window.open('ConductBIMSAssessment.aspx' + listView_QueryStringTokenWithMandatoryQuestionMarkAndOptionalAmpersand, 'BIMS Assessments', 'top=50px,left=100px,height=650px,width=1000px,resizable=no,scrollbars=no,toolbar=no,menubar=no,location=no');
            event.stopPropagation();
            return false;
        }
        function setBIMSScoreAndDate(score, date) {
            document.getElementById('<%=lblBIMSScore.ClientID%>').innerHTML = score;
            document.getElementById('<%=lblBIMSDate.ClientID%>').innerHTML = date;
        }
        function setAppointedRepresentative(AppointedRep1, AppointedRep2) {
            if (document.getElementById('<%=lblPatientRepName.ClientID%>') != null)
                document.getElementById('<%=lblPatientRepName.ClientID%>').innerHTML = AppointedRep1 + ' ' + AppointedRep2;
            if (document.getElementById('<%=lblCMRPatientRepName.ClientID%>') != null)
                document.getElementById('<%=lblCMRPatientRepName.ClientID%>').innerHTML = AppointedRep1 + ' ' + AppointedRep2;

            var hdnFirstName = document.getElementById("<%= hdnAppRepFirstName.ClientID %>");
            var hdnLastName = document.getElementById("<%= hdnAppRepLastName.ClientID %>");
            //            hdnFirstName.Value = AppointedRep1;
            //            hdnLastName.Value = AppointedRep2;
            if (document.getElementById('<%=hdnAppRepFirstName.ClientID%>') != null)
                document.getElementById("<%= hdnAppRepFirstName.ClientID %>").value = AppointedRep1;
            if (document.getElementById('<%=hdnAppRepLastName.ClientID%>') != null)
                document.getElementById("<%= hdnAppRepLastName.ClientID %>").value = AppointedRep2;

            var ChangeBtn = document.getElementById("<%=lnkChangeRecpientName.ClientID %>");
            if (ChangeBtn != null)
                ChangeBtn.innerHTML = "Change";

            var ChangeBtnCMR = document.getElementById("<%=lnkCMRChangeRecpientName.ClientID %>");
            if (ChangeBtnCMR != null)
                ChangeBtnCMR.innerHTML = "Change";
        }
        var isInvalidPhoneNumberChecked = false;


        function getPrescribersListCallManagement(Isprescriber) {

            $.ajax({
                url: '../Services/RxConService.asmx/LoadPrescribers'
                , type: "POST"
                 , contentType: "application/json"
                 , dataType: "json"
                , data: JSON.stringify({
                    PatientRxHistoryID: Isprescriber
                }),
                success: function (result) {
                    if (Isprescriber == 1) {
                        BindPrescriberProviderCombo(1, result.d);
                    } else {
                        BindPrescriberProviderCombo(2, result.d);
                    }
                }
            });
        }
        function getCMRPrescribersListCallManagement(Isprescriber) {

            $.ajax({
                url: '../Services/RxConService.asmx/LoadPrescribers'
                , type: "POST"
                 , contentType: "application/json"
                 , dataType: "json"
                , data: JSON.stringify({
                    PatientRxHistoryID: Isprescriber
                }),
                success: function (result) {
                    if (Isprescriber == 1) {
                        BindCMRPrescriberProviderCombo(1, result.d);
                    } else {
                        BindCMRPrescriberProviderCombo(2, result.d);
                    }
                }
            });
        }
        function getPharmacyListCallManagement() {

            $.ajax({
                url: '../Services/RxConService.asmx/LoadPharmacists'
                , type: "POST"
                 , contentType: "application/json"
                 , dataType: "json"
                 , data: {},
                success: function (result) {
                    BindPharmacylistCombo(result.d);
                }
            });
        }
        function getDispositionTypes(callType, selectedTextCMRCMBRecipient) {

            $.ajax({
                url: '../Services/RxConService.asmx/LoadDispositions'
                , type: "POST"
                 , contentType: "application/json"
                 , dataType: "json"
                , data: JSON.stringify({
                    CallType: callType,
                    RecipientType: selectedTextCMRCMBRecipient
                }),
                success: function (result) {
                    BindDispositionCombo(result.d);

                }
            });
        }

        function BindDispositionCombo(result) {
            var cmbRecipientType = $find("<%=cmbRecipientType.ClientID %>");
            var selectedTextCMRCMBRecipient = cmbRecipientType.get_selectedItem().get_text();
            //            if (selectedTextCMRCMBRecipient == 'Pharmacy') { 
            //            
            //            }
            var comboDisposition;
            comboDisposition = $find('<%=cmbCMDisposition.ClientID %>');
            comboDisposition.clearItems();
            comboDisposition.trackChanges();

            var comboItem = new Telerik.Web.UI.RadComboBoxItem();
            comboItem.set_value("0");
            comboItem.set_text("Select");


            if (item == null)
                comboDisposition.get_items().add(comboItem);

            for (i = 0; i < result.length; i++) {

                var value = result[i].LookUpValue;
                var name = result[i].LookUpText;



                var comboItem = new Telerik.Web.UI.RadComboBoxItem();
                comboItem.set_value(value);
                comboItem.set_text(name);

                var item = comboDisposition.findItemByText(name);
                if (item == null)
                    comboDisposition.get_items().add(comboItem);
            }
            comboDisposition.commitChanges();

            var itemselect = comboDisposition.findItemByText('Select');
            itemselect.select();


        }

        function BindPrescriberProviderCombo(isPrescriber, result) {

            var comboPrescribers;
            if (isPrescriber == 1) {
                comboPrescribers = $find('<%=cmbPrescribers.ClientID %>');
                $("[id*=trPrescribersList]").css('display', '');
                $("[id*=trProviders]").css('display', 'none');

            } else {
                comboPrescribers = $find('<%=cmbProviders.ClientID %>');
                $("[id*=trProviders]").css('display', '');
                $("[id*=trPrescribersList]").css('display', 'none');
            }

            comboPrescribers.clearItems();
            comboPrescribers.trackChanges();

            var comboItem1 = new Telerik.Web.UI.RadComboBoxItem();
            comboItem1.set_value("0");
            comboItem1.set_text("Select");
            var item = comboPrescribers.findItemByText("Select");
            if (item == null)
                comboPrescribers.get_items().add(comboItem1);

            for (i = 0; i < result.length; i++) {

                var recipientId = result[i].RecipientId;
                var npi = result[i].NPI;
                var name = result[i].PrescriberName;

                var comboItem = new Telerik.Web.UI.RadComboBoxItem();
                comboItem.set_value(recipientId);
                comboItem.set_text(name);

                var item = comboPrescribers.findItemByText(name);
                if (item == null)
                    comboPrescribers.get_items().add(comboItem);
            }
            var comboItem1 = new Telerik.Web.UI.RadComboBoxItem();
            comboItem1.set_value("-1");
            comboItem1.set_text("Other");

            var item = comboPrescribers.findItemByText("Other");
            if (item == null)
                comboPrescribers.get_items().add(comboItem1);



            comboPrescribers.commitChanges();

            var item = comboPrescribers.findItemByText("Select");
            if (item != null)
                item.select();

        }

        function BindCMRPrescriberProviderCombo(isPrescriber, result) {

            var comboPrescribers;
            if (isPrescriber == 1) {
                comboPrescribers = $find('<%=cmrPrescribers.ClientID %>');
                $("[id*=trCMRPrescribers]").css('display', '');
                $("[id*=trCMRProviders]").css('display', 'none');

            } else {
                comboPrescribers = $find('<%=cmrProviders.ClientID %>');
                $("[id*=trCMRProviders]").css('display', '');
                $("[id*=trCMRPrescribers]").css('display', 'none');
            }

            comboPrescribers.clearItems();
            comboPrescribers.trackChanges();

            var comboItem1 = new Telerik.Web.UI.RadComboBoxItem();
            comboItem1.set_value("0");
            comboItem1.set_text("Select");
            var item = comboPrescribers.findItemByText("Select");
            if (item == null)
                comboPrescribers.get_items().add(comboItem1);

            for (i = 0; i < result.length; i++) {
                var recipientId = result[i].RecipientId;
                var npi = result[i].NPI;
                var name = result[i].PrescriberName;

                var comboItem = new Telerik.Web.UI.RadComboBoxItem();
                comboItem.set_value(recipientId);
                comboItem.set_text(name);

                var item = comboPrescribers.findItemByText(name);
                if (item == null)
                    comboPrescribers.get_items().add(comboItem);
            }
            var comboItem1 = new Telerik.Web.UI.RadComboBoxItem();
            comboItem1.set_value("-1");
            comboItem1.set_text("Other");

            var item = comboPrescribers.findItemByText("Other");
            if (item == null)
                comboPrescribers.get_items().add(comboItem1);

            comboPrescribers.commitChanges();

            var item = comboPrescribers.findItemByText("Select");
            if (item != null)
                item.select();

        }
        function BindPharmacylistCombo(result) {
            var comboPharmacist;
            comboPharmacist = $find('<%=cmbPharmacist.ClientID %>');
            $("[id*=trPharmacists]").css('display', '');

            comboPharmacist.clearItems();
            comboPharmacist.trackChanges();

            var comboItem1 = new Telerik.Web.UI.RadComboBoxItem();
            comboItem1.set_value("0");
            comboItem1.set_text("Select");
            var item = comboPharmacist.findItemByText("Select");
            if (item == null)
                comboPharmacist.get_items().add(comboItem1);


            for (i = 0; i < result.length; i++) {

                var userId = result[i].UserId;
                var userName = result[i].UserName;

                var comboItem = new Telerik.Web.UI.RadComboBoxItem();
                comboItem.set_value(userId);
                comboItem.set_text(userName);

                var item = comboPharmacist.findItemByText(userName);
                if (item == null)
                    comboPharmacist.get_items().add(comboItem);
            }

            comboPharmacist.commitChanges();
            var item = comboPharmacist.findItemByText("Select");
            if (item != null)
                item.select();


        }

        function checkCMRScheduled(chkFollowUp) {
            var CMRRecipient = $find("<%= cmbCMRRecipient.ClientID %>");
            //Added for Ticket#16533.
            document.getElementById("<%=hdnCheckFollowUpAttempts.ClientID%>").value = "0"
            //Added for Ticket#16624.
            document.getElementById("<%=hdnFollowUpHidden.ClientID%>").value = "0";
            if (chkFollowUp.checked) {
                CMRRecipient.enable();
                var itmRecipient = CMRRecipient.findItemByValue('0');
                itmRecipient.select();
                $("[id*=spanScheduledDate]").text('CMR Scheduled Date:');
                $("[id*=spnRecipientOfCMR]").text('Recipient of CMR:');
                var datepicker = $find("<%= RDPCMRScheduledDate.ClientID %>");
                datepicker.set_enabled(true);
                datepicker.clear();
                $("[id*=trRecipientOfCMR]").css('display', '');
                //By default hide App Rep/ Contact name below
                $("[id*=trRecipientOfCMRAppointedRep]").css('display', 'none');
                $("[id*=trRecipientOfCMRContactName]").css('display', 'none');

                $("[id*=trCMRScheduledDate]").css('display', '');
                $("[id*=chkCMRFollowUp]").removeAttr('checked');
                $("[id*=chkFollowUpAttemptCompleted]").removeAttr('checked');

                //Added for CR-1047
                $("[id*=chkCMRFollowUp]").css('display', 'none');
                $("[id*=chkFollowUpAttemptCompleted]").css('display', 'none');
                $("[id*=spnFollowupRequired]").css('display', 'none');
                $("[id*=spnFollowupCompleted]").css('display', 'none');
                $("[id*=lblFollowUpCounter]").css('display', 'none');

                $("[id*=lnkScheduleAppointment]").removeAttr('disabled');
                $("[id*=lnkScheduleAppointment]").css('color', '#0101DF');
                $("[id*=lnkScheduleAppointment]").css('cursor', 'pointer');

            } else {

                //Added for CR-1047
                $("[id*=chkCMRFollowUp]").css('display', '');
                $("[id*=chkFollowUpAttemptCompleted]").css('display', '');
                $("[id*=spnFollowupRequired]").css('display', '');
                $("[id*=spnFollowupCompleted]").css('display', '');
                $("[id*=lblFollowUpCounter]").css('display', '');


                $("[id*=chkFollowUpAttemptCompleted]").attr('disabled', false);
                $("[id*=chkCMRFollowUp]").attr('disabled', false);
                $("[id*=trRecipientOfCMR]").css('display', 'none');
                $("[id*=trCMRPrescribers]").css('display', 'none');
                $("[id*=trCMRProviders]").css('display', 'none');
                $("[id*=trCMRScheduledDate]").css('display', 'none');

            }
        }

        function checkFollowUp(chkFollowUp) {
            var CMRRecipient = $find("<%= cmbCMRRecipient.ClientID %>");

            //Added for Ticket#16533.
            document.getElementById("<%=hdnCheckFollowUpAttempts.ClientID%>").value = "0";

            if (chkFollowUp.checked) {

                //Added for Ticket#16624.
                document.getElementById("<%=hdnFollowUpHidden.ClientID%>").value = "1";

                $("[id*=spanScheduledDate]").text('Follow-Up Date:');
                $("[id*=spnRecipientOfCMR]").text('Follow-Up with:');

                $("[id*=cmkCMRScheduled]").removeAttr('checked');
                $("[id*=chkFollowUpAttemptCompleted]").removeAttr('checked');

                //Added for CR-1047.
                $("[id*=cmkCMRScheduled]").css('display', 'none');
                $("[id*=spnCMRScheduled]").css('display', 'none');
                $("[id*=chkFollowUpAttemptCompleted]").attr('disabled', true);

                $("[id*=trCMRScheduledDate]").css('display', '');
                CMRRecipient.enable();
                var itmRecipient = CMRRecipient.findItemByValue('0');
                itmRecipient.select();
                /****CR 420***/

                $("[id*=trRecipientOfCMR]").css('display', '');
                //By default hide App Rep/ Contact name below
                $("[id*=trRecipientOfCMRAppointedRep]").css('display', 'none');
                $("[id*=trRecipientOfCMRContactName]").css('display', 'none');



                var datepicker = $find("<%= RDPCMRScheduledDate.ClientID %>");
                datepicker.set_enabled(true);
                datepicker.clear();
                var combo = $find("<%= cmbCMROptOut.ClientID %>");
                var itm = combo.findItemByValue('0');
                itm.select();
                combo.disable();
                combo = $find("<%= cmbMTMOptOut.ClientID %>");
                itm = combo.findItemByValue('0');
                itm.select();
                combo.disable();

                /***Ajay cr420
                combo = $find("<%= cmbCMRRecipient.ClientID %>");
                itm = combo.findItemByValue('0');
                itm.select();
                combo.disable();
                ***/


                $("[id*=lnkScheduleAppointment]").attr('disabled', true);
                $("[id*=lnkScheduleAppointment]").css('color', '#767676');
                $("[id*=lnkScheduleAppointment]").css('cursor', 'default');
            }
            else {

                //Added for Ticket#16624.
                document.getElementById("<%=hdnFollowUpHidden.ClientID%>").value = "0";

                //Added for CR-1047.
                $("[id*=cmkCMRScheduled]").css('display', '');
                $("[id*=spnCMRScheduled]").css('display', '');
                $("[id*=chkFollowUpAttemptCompleted]").attr('disabled', false);

                $("[id*=chkFollowUpAttemptCompleted]").removeAttr('disabled');
                $("[id*=trCMRScheduledDate]").css('display', 'none');
                $("[id*=trRecipientOfCMR]").css('display', 'none');
                $("[id*=trCMRPrescribers]").css('display', 'none');
                $("[id*=trCMRProviders]").css('display', 'none');
                //$("[id*=cmkCMRScheduled]").attr('disabled', false);
                $("[id*=chkFollowUpAttemptCompleted]").attr('disabled', false);


                $("[id*=lnkScheduleAppointment]").removeAttr('disabled');
                $("[id*=lnkScheduleAppointment]").css('color', '#0101DF');
                $("[id*=lnkScheduleAppointment]").css('cursor', 'pointer');

                //Commented trhe below code for Tciket#16634
                //var combo = $find("<%= cmbCMROptOut.ClientID %>");
                //combo.enable();
                //var combo = $find("<%= cmbMTMOptOut.ClientID %>");
                //combo.enable();
                combo = $find("<%= cmbPatientImpaired.ClientID %>");
                combo.enable();
                combo = $find("<%= cmbCMRRecipient.ClientID %>");
                combo.enable();
                var datepicker = $find("<%= RDPCMRScheduledDate.ClientID %>");
                datepicker.set_enabled(true);
                var datepickerED = $find("<%=RadDateCIEffectiveDate.ClientID %>");
                datepickerED.set_enabled(true);
            }
        }
        function checkFollowUpAttempts(chkFollowUpAttempts) {

            //Added for Ticket#16624.
            document.getElementById("<%=hdnFollowUpHidden.ClientID%>").value = "0";

            if (chkFollowUpAttempts.checked) {

                //Added for Ticket#16533.
                document.getElementById("<%=hdnCheckFollowUpAttempts.ClientID%>").value = "1";

                $("[id*=chkCMRFollowUp]").removeAttr('checked');
                $("[id*=cmkCMRScheduled]").removeAttr('checked');

                //Added for CR-1047.
                $("[id*=cmkCMRScheduled]").css('display', 'none');
                $("[id*=spnCMRScheduled]").css('display', 'none');
                $("[id*=chkCMRFollowUp]").attr('disabled', true);



                /****CR 420***/

                $("[id*=trRecipientOfCMR]").css('display', '');
                //For Follow up attempts complete, hide Follow up with, Follow up Date.
                $("[id*=trRecipientOfCMRAppointedRep]").css('display', 'none');
                $("[id*=trRecipientOfCMRContactName]").css('display', 'none');
                $("[id*=trRecipientOfCMR]").css('display', 'none');
                $("[id*=trCMRScheduledDate]").css('display', '');
                $("[id*=spanScheduledDate]").text('Follow-Up Date:');

                var combo = $find("<%= cmbCMROptOut.ClientID %>");
                var itm = combo.findItemByValue('0');
                itm.select();
                combo.disable();
                var cmbMTMOptOut = $find("<%= cmbMTMOptOut.ClientID %>");
                var itm1 = cmbMTMOptOut.findItemByValue('0');
                itm1.select();
                cmbMTMOptOut.disable();
                combo = $find("<%= cmbCMRRecipient.ClientID %>");
                itm = combo.findItemByValue('0');
                itm.select();
                combo.disable();

                var datepicker = $find("<%= RDPCMRScheduledDate.ClientID %>");
                datepicker.clear();
                datepicker.set_enabled(false);

                $("[id*=lnkScheduleAppointment]").attr('disabled', true);
                $("[id*=lnkScheduleAppointment]").css('color', '#767676');
                $("[id*=lnkScheduleAppointment]").css('cursor', 'default');
            }
            else {

                //Added for Ticket#16533.
                document.getElementById("<%=hdnCheckFollowUpAttempts.ClientID%>").value = "0";

                $("[id*=chkCMRFollowUp]").removeAttr('disabled');

                $("[id*=chkCMRFollowUp]").attr('disabled', false);
                // $("[id*=cmkCMRScheduled]").attr('disabled', false);

                //Added for CR-1047.
                $("[id*=cmkCMRScheduled]").css('display', '');
                $("[id*=spnCMRScheduled]").css('display', '');
                $("[id*=chkCMRFollowUp]").attr('disabled', false);
                //Added for Ticket# 14818
                $("[id*=trCMRScheduledDate]").css('display', 'none');

                $("[id*=trCheckboxes]").css('display', '');
                $("[id*=lnkScheduleAppointment]").removeAttr('disabled');
                $("[id*=lnkScheduleAppointment]").css('color', '#0101DF');
                $("[id*=lnkScheduleAppointment]").css('cursor', 'pointer');

                //Commented trhe below code for Tciket#16634
                //var combo = $find("<%= cmbCMROptOut.ClientID %>");
                // combo.enable();
                //combo = $find("<%= cmbMTMOptOut.ClientID %>");
                //combo.enable();
                combo = $find("<%= cmbPatientImpaired.ClientID %>");
                combo.enable();
                combo = $find("<%= cmbCMRRecipient.ClientID %>");
                combo.enable();
                var datepicker = $find("<%= RDPCMRScheduledDate.ClientID %>");
                datepicker.set_enabled(true);
                var datepickerED = $find("<%=RadDateCIEffectiveDate.ClientID %>");
                datepickerED.set_enabled(true);
                //                if ($("[id*=hdnFollowUpCounter]").val() >= "3") {
                //                    $("[id*=chkCMRFollowUp]").attr('disabled', true);
                //                    $("[id*=rdppreCMRFollowUpDate]").attr('disabled', true);
                //                    $("[id*=ChkInvalidPhoneNumber]").attr('disabled', true);
                //                    // return false;
                //                }
            }
        }
        function clientCloseCMRAppointment(oWnd) {
            var arg = oWnd.argument;
            if (arg != null && arg != "") {
                var radStartTime = $find("<%= RDPCMRScheduledDate.ClientID %>");
                radStartTime.set_selectedDate(new Date(arg.split("|")[0]));
                var hdnTimeZone = document.getElementById("<%= hdnTimeZone.ClientID %>");
                hdnTimeZone.value = arg.split("|")[1];
                var lnkTimeZone = document.getElementById("<%= lnkTimeZone.ClientID %>");
                lnkTimeZone.innerHTML = arg.split("|")[1];
            }
            else if (arg == "") {
                var radStartTime = $find("<%= RDPCMRScheduledDate.ClientID %>");
                radStartTime.clear();
            }
        }

        function validateRecipientWhileSaving(sender) {

            var validation = '';
            var firstNameCMr = $("[id*=txtCMRContactFirstName]").val().trim();
            var LastNameCMr = $("[id*=txtCMRContactLastName]").val().trim();

            var ischkCMRFollowUpChecked = $("[id*=chkCMRFollowUp]").prop('checked');
            var ischkCMRScheduled = $("[id*=cmkCMRScheduled]").prop('checked');


            var cmbRecipientType = $find("<%=cmbRecipientType.ClientID %>");
            var cmbCMRRecipientType = $find("<%=cmbCMRRecipient.ClientID %>");
            var objCMRScheduledDate = $find("<%= RDPCMRScheduledDate.ClientID %>");

            var cmbRelationToBeneficiary_MTM = $find("<%=cmbRelationToBeneficiary_MTM.ClientID %>");
            var itemValue = cmbRelationToBeneficiary_MTM.get_selectedItem().get_value();

            var selectedTextCMRCMBRecipient = cmbCMRRecipientType.get_selectedItem().get_text();
            var txt_txtSubOtherNPI2 = $("[id*=txtSubOtherNPI2]").val().trim();
            var txt_txtSubOtherNPI3 = $("[id*=txtSubOtherNPI3]").val().trim();
            var labelCMRAppointedRepresentative = document.getElementById('<%=lblCMRPatientRepName.ClientID%>').innerHTML;


            var selectedTextCMBRecipient = cmbRecipientType.get_selectedItem().get_text();
            selectedTextCMRCMBRecipient = selectedTextCMRCMBRecipient.replace(/[0-9]/g, '');
            selectedTextCMRCMBRecipient = selectedTextCMRCMBRecipient.replace('-', '').trim();
            var combo_cmrPrescribers = $find("<%=cmrPrescribers.ClientID %>");
            var date = objCMRScheduledDate._dateInput._text;
            if (date.trim() == '') {
                if (ischkCMRFollowUpChecked)
                    validation = 'Please select Follow-Up Date';
                if (ischkCMRScheduled)
                    validation = 'Please select CMR Scheduled Date';
            }



            else if (selectedTextCMRCMBRecipient == 'Select') {
                if (ischkCMRFollowUpChecked)
                    validation = 'Please select Follow-Up with';
                if (ischkCMRScheduled)
                    validation = 'Please select Recipient of CMR';
            }
            else if (selectedTextCMBRecipient.toLowerCase() == selectedTextCMRCMBRecipient.toLowerCase()) {
                validation = '';
            }
            else {

                if (selectedTextCMRCMBRecipient.toLowerCase() == "beneficiary") {
                    //1. Check whether name entered in below Name controls
                    if (firstNameCMr == '' || LastNameCMr == '') {
                        validation = 'Please enter name';
                    }

                }
                else if (selectedTextCMRCMBRecipient.toLowerCase() == "beneficiary's prescriber") {

                    if (combo_cmrPrescribers.get_selectedItem().get_value() == 0) {
                        validation = 'Please select Prescriber';
                    } else if (combo_cmrPrescribers.get_selectedItem().get_value() == -1) {
                        if (txt_txtSubOtherNPI2 == '' || txt_txtSubOtherNPI3 == '') {
                            validation = 'Please select Other name';

                        }
                    }


                }
                else if (selectedTextCMRCMBRecipient.toLowerCase() == "caregiver" || selectedTextCMRCMBRecipient.toLowerCase() == "other authorized individual") {
                    if (labelCMRAppointedRepresentative == 'No Appointed Rep') {
                        validation = 'Please add Appointed representative';
                    }
                }
            }
            return validation;
        }
        function validateRecipientOfCMRCombobox(selectedTextCMBRecipient, selectedTextCMRCMBRecipient) {

            var isCMRScheduled = $("[id*=cmkCMRScheduled]").is(':checked');

            /** First Hide all Above section controls(Recipient)**/
            $("[id*=MainContent_ucCMRTMR_trContactName]").css('display', 'none');
            $("[id*=trRecipientOfCMRContactName]").css('display', 'none');
            $("[id*=MainContent_ucCMRTMR_trAppointedRep]").css('display', 'none');
            $("[id*=trProviders]").css('display', 'none');
            $("[id*=trPrescribersList]").css('display', 'none');
            $("[id*=trCMRPrescriberProviderOther]").css('display', 'none');

            /**First Hide all below section controls(Recipient of CMR)**/
            $("[id*=trCMRPrescribers]").css('display', 'none');
            $("[id*=trCMRProviders]").css('display', 'none');
            $("[id*=trRecipientOfCMRContactName]").css('display', 'none');
            $("[id*=trRecipientOfCMRAppointedRep]").css('display', 'none');

            var prefix = document.getElementById('MainContent_hdnPrefix').value.trim();
            var FirstName = document.getElementById('MainContent_hdnFirstName').value.trim();
            var LastName = document.getElementById('MainContent_hdnLastName').value.trim();


            //Based on the logic two recipients show only the needed controls
            //Logic 1: If Recipient type and Recipient of CMR both are same, we will display Name/ App Rep/ Pres list/ Prov list only above not below.
            if (selectedTextCMBRecipient == selectedTextCMRCMBRecipient) {
                if (selectedTextCMBRecipient.toLowerCase() == 'caregiver' || selectedTextCMBRecipient.toLowerCase() == 'other authorized individual') {
                    $("[id*=MainContent_ucCMRTMR_trAppointedRep]").css('display', '');
                } else if (selectedTextCMBRecipient.toLowerCase() == "beneficiary's prescriber") {
                    $("[id*=trPrescribersList]").css('display', '');
                    $("[id*=trProviders]").css('display', 'none');

                }
                else if (selectedTextCMBRecipient.toLowerCase() == 'beneficiary') {

                    $("[id*=MainContent_ucCMRTMR_trContactName]").css('display', '');
                    $("[id*=txtCMRContactPrefix]").val(prefix);
                    $("[id*=txtCMRContactFirstName]").val(FirstName);
                    $("[id*=txtCMRContactLastName]").val(LastName);
                }
                else if (selectedTextCMBRecipient.toLowerCase() == "pharmacy") {
                    $("[id*=trPrescribersList]").css('display', 'none');
                    $("[id*=trProviders]").css('display', '');

                }

            } else {

                /*Logic2: In case Recipient CMR & Recipient do not matches, Above conditions, based on condition show one by one control***/
                /**Logic2: Above Section Controls(Recipient)**/

                //Or conditionadded for CR-1047.
                if (selectedTextCMBRecipient.toLowerCase() == "beneficiary" || selectedTextCMBRecipient.toLowerCase() == 'other') {
                    $("[id*=MainContent_ucCMRTMR_trContactName]").css('display', '');

                } else if (selectedTextCMBRecipient.toLowerCase() == "beneficiary's prescriber") {
                    //getPrescribersListCallManagement(1);

                    $("[id*=trPrescribersList]").css('display', '');
                    $("[id*=trProviders]").css('display', 'none');

                } else if (selectedTextCMBRecipient.toLowerCase() == 'caregiver' || selectedTextCMBRecipient.toLowerCase() == 'other authorized individual') {
                    $("[id*=MainContent_ucCMRTMR_trAppointedRep]").css('display', '');
                } else if (selectedTextCMBRecipient.toLowerCase() == 'pharmacy') {

                    $("[id*=trPrescribersList]").css('display', 'none');
                    $("[id*=trProviders]").css('display', '');
                }
                /**Logic2: Below Section Controls(Recipient of CMR)**/
                if (selectedTextCMRCMBRecipient.toLowerCase() == "beneficiary") {
                    $("[id*=trRecipientOfCMRContactName]").css('display', '');
                    $("[id*=trCMRPrescriberProviderOther]").css('display', 'none');
                    $("[id*=txtCMRContactPrefix]").val(prefix);
                    $("[id*=txtCMRContactFirstName]").val(FirstName);
                    $("[id*=txtCMRContactLastName]").val(LastName);
                } else if (selectedTextCMRCMBRecipient.toLowerCase() == "beneficiary's prescriber") {
                    $("[id*=trCMRPrescribers]").css('display', '');
                    $("[id*=trCMRProviders]").css('display', 'none');
                    getCMRPrescribersListCallManagement(1);
                } else if (selectedTextCMRCMBRecipient.toLowerCase() == 'caregiver' || selectedTextCMRCMBRecipient.toLowerCase() == 'other authorized individual') {
                    $("[id*=trRecipientOfCMRAppointedRep]").css('display', '');
                    $("[id*=trCMRPrescriberProviderOther]").css('display', 'none');
                } else if (selectedTextCMRCMBRecipient.toLowerCase() == 'pharmacy') {
                    $("[id*=trCMRPrescribers]").css('display', 'none');
                    $("[id*=trCMRProviders]").css('display', '');
                }

                /**Logic 3:**/
                /**For Aor/Caregiver Logic, if either of one seected in Above Section and Below section 
                We alwasy display Care giver link in aboev scetion only**/

                if ((selectedTextCMBRecipient.toLowerCase() == 'caregiver' || selectedTextCMBRecipient.toLowerCase() == 'other authorized individual') &&
                (selectedTextCMRCMBRecipient.toLowerCase() == 'caregiver' || selectedTextCMRCMBRecipient.toLowerCase() == 'other authorized individual')
                ) {

                    $("[id*=MainContent_ucCMRTMR_trAppointedRep]").css('display', '');
                    $("[id*=trRecipientOfCMRAppointedRep]").css('display', 'none');

                }

            }


        }

        var recipientOfCMRSelectedOnce = 0;
        function CMRRecipientChanged(sender, eventArgs) {
            var item = eventArgs.get_item();

            var cmbRecipientType = $find("<%=cmbRecipientType.ClientID %>");
            var selectedTextCMBRecipient = cmbRecipientType.get_selectedItem().get_text();
            var selectedTextCMRCMBRecipient = item.get_text();
            selectedTextCMRCMBRecipient = selectedTextCMRCMBRecipient.replace(/[0-9]/g, '');
            selectedTextCMRCMBRecipient = selectedTextCMRCMBRecipient.replace('-', '').trim();
            //If selected 'Select' Hide all below controls
            if (recipientOfCMRSelectedOnce == 1 && eventArgs.get_item().get_value() == 0) {
                $("[id*=trCMRPrescribers]").css('display', 'none');
                $("[id*=trCMRProviders]").css('display', 'none');
                $("[id*=trRecipientOfCMRContactName]").css('display', 'none');
                $("[id*=trRecipientOfCMRAppointedRep]").css('display', 'none');
                $("[id*=trCMRPrescriberProviderOther]").css('display', 'none');

            }
            var itemText = eventArgs.get_item()._text;
            if (itemText != 'Select') {
                recipientOfCMRSelectedOnce = 1;
                //validateRecipientOfCMR();
                validateRecipientOfCMRCombobox(selectedTextCMBRecipient, selectedTextCMRCMBRecipient);
            }


        }

        function validateRecipientOfCMR() {

            var cmbRecipientType = $find("<%=cmbRecipientType.ClientID %>");
            var cmbCMRRecipientType = $find("<%=cmbCMRRecipient.ClientID %>");

            var selectedTextCMBRecipient = cmbCMRRecipientType.get_selectedItem().get_text();

            var selectedTextCMRCMBRecipient = cmbRecipientType.get_selectedItem().get_text();
            selectedTextCMRCMBRecipient = selectedTextCMRCMBRecipient.replace(/[0-9]/g, '');
            selectedTextCMRCMBRecipient = selectedTextCMRCMBRecipient.replace('-', '').trim();



            var isCMRScheduled = $("[id*=cmkCMRScheduled]").is(':checked');

            /** First Hide all Above section controls(Recipient)**/
            $("[id*=MainContent_ucCMRTMR_trContactName]").css('display', 'none');
            $("[id*=trRecipientOfCMRContactName]").css('display', 'none');
            $("[id*=MainContent_ucCMRTMR_trAppointedRep]").css('display', 'none');
            $("[id*=trProviders]").css('display', 'none');
            $("[id*=trPrescribersList]").css('display', 'none');

            /**First Hide all below section controls(Recipient of CMR)**/
            $("[id*=trCMRPrescribers]").css('display', 'none');
            $("[id*=trCMRProviders]").css('display', 'none');
            $("[id*=trRecipientOfCMRContactName]").css('display', 'none');
            $("[id*=trRecipientOfCMRAppointedRep]").css('display', 'none');

            //Based on the logic two recipients show only the needed controls
            //Logic 1: If Recipient type and Recipient of CMR both are same, we will display Name/ App Rep/ Pres list/ Prov list only above not below.
            if (selectedTextCMBRecipient == selectedTextCMRCMBRecipient) {
                if (selectedTextCMBRecipient.toLowerCase() == 'caregiver' || selectedTextCMBRecipient.toLowerCase() == 'other authorized individual') {
                    $("[id*=MainContent_ucCMRTMR_trAppointedRep]").css('display', '');
                } else if (selectedTextCMBRecipient.toLowerCase() == "beneficiary's prescriber") {
                    $("[id*=trPrescribersList]").css('display', '');
                    $("[id*=trProviders]").css('display', 'none');

                }
                else if (selectedTextCMBRecipient.toLowerCase() == 'beneficiary') {

                    $("[id*=MainContent_ucCMRTMR_trContactName]").css('display', '');
                }
                else if (selectedTextCMBRecipient.toLowerCase() == "pharmacy") {
                    $("[id*=trPrescribersList]").css('display', 'none');
                    $("[id*=trProviders]").css('display', '');

                }

            } else {

                /*Logic2: In case Recipient CMR & Recipient do not matches, Above conditions, based on condition show one by one control***/
                /**Logic2: Above Section Controls(Recipient)**/
                if (selectedTextCMBRecipient.toLowerCase() == "beneficiary") {
                    $("[id*=MainContent_ucCMRTMR_trContactName]").css('display', '');
                } else if (selectedTextCMBRecipient.toLowerCase() == "beneficiary's prescriber") {
                    getPrescribersListCallManagement(1);
                } else if (selectedTextCMBRecipient.toLowerCase() == 'caregiver' || selectedTextCMBRecipient.toLowerCase() == 'other authorized individual') {
                    $("[id*=MainContent_ucCMRTMR_trAppointedRep]").css('display', '');
                } else if (selectedTextCMRCMBRecipient.toLowerCase() == 'pharmacy') {
                    getPrescribersListCallManagement(2);
                }
                /**Logic2: Below Section Controls(Recipient of CMR)**/
                if (selectedTextCMRCMBRecipient.toLowerCase() == "beneficiary") {
                    $("[id*=trRecipientOfCMRContactName]").css('display', '');
                } else if (selectedTextCMRCMBRecipient.toLowerCase() == "beneficiary's prescriber") {
                    getCMRPrescribersListCallManagement(1);
                } else if (selectedTextCMRCMBRecipient.toLowerCase() == 'caregiver' || selectedTextCMRCMBRecipient.toLowerCase() == 'other authorized individual') {
                    $("[id*=trRecipientOfCMRAppointedRep]").css('display', '');
                } else if (selectedTextCMRCMBRecipient.toLowerCase() == 'pharmacy') {
                    getCMRPrescribersListCallManagement(2);
                }

                /**Logic 3:**/
                /**For Aor/Caregiver Logic, if either of one seected in Above Section and Below section 
                We alwasy display Care giver link in aboev scetion only**/

                if ((selectedTextCMBRecipient.toLowerCase() == 'caregiver' || selectedTextCMBRecipient.toLowerCase() == 'other authorized individual') &&
                (selectedTextCMRCMBRecipient.toLowerCase() == 'caregiver' || selectedTextCMRCMBRecipient.toLowerCase() == 'other authorized individual')
                ) {

                    $("[id*=MainContent_ucCMRTMR_trAppointedRep]").css('display', '');
                    $("[id*=trRecipientOfCMRAppointedRep]").css('display', 'none');

                }

            }


        }
        /***Duplicate
        function CMRRecipientChanged(sender, eventArgs) {
        var item = eventArgs.get_item();
        var cmbRecipientType = $find("<%=cmbRecipientType.ClientID %>");
        var selectedTextCMBRecipient = cmbRecipientType.get_selectedItem().get_text();
        var selectedTextCMRCMBRecipient = item.get_text();
        selectedTextCMRCMBRecipient = selectedTextCMRCMBRecipient.replace(/[0-9]/g, '');
        selectedTextCMRCMBRecipient = selectedTextCMRCMBRecipient.replace('-', '').trim();

        var itemText = eventArgs.get_item()._text;
        if (itemText != 'Select') {
        //validateRecipientOfCMR();
        validateRecipientOfCMRCombobox(selectedTextCMBRecipient, selectedTextCMRCMBRecipient);
        }


        }
        **/
        function hideCMRScheduledSecion(hide) {
            if (hide) {
                $("[id*=divCMRScheduledCheckbox]").css('display', 'none');
                $("[id*=trCMRScheduledDate]").css('display', 'none');
                $("[id*=trRecipientOfCMR]").css('display', 'none');

            } else {
                $("[id*=trCheckboxes]").css('display', '');
                $("[id*=divCMRScheduledCheckbox]").css('display', '');
                $("[id*=trCMRScheduledDate]").css('display', '');
                $("[id*=trRecipientOfCMR]").css('display', '');
            }
        }
        function hideFollowupScheduledSecion(hide) {
            if (hide) {
                $("[id*=divFollowupRequiredCheckbox]").css('display', 'none');
                $("[id*=divFollowupCompletedRequiredCheckbox]").css('display', 'none');
                $("[id*=trCMRScheduledDate]").css('display', 'none');
                $("[id*=trRecipientOfCMR]").css('display', 'none');

            } else {

                $("[id*=divFollowupRequiredCheckbox]").css('display', '');
                $("[id*=trCheckboxes]").css('display', '');
                $("[id*=divFollowupCompletedRequiredCheckbox]").css('display', '');
                $("[id*=trCMRScheduledDate]").css('display', '');
                $("[id*=trRecipientOfCMR]").css('display', '');
            }
        }

        var isDispositionselectedOnce = 0;
        function cmbCMDispositionChanged(sender, eventArgs) {
            var combo_cmbMTMCallType = $find("<%=cmbMTMCallType.ClientID %>");
            var CallType = combo_cmbMTMCallType.get_selectedItem().get_value();

            var cmbRecipientType = $find("<%=cmbRecipientType.ClientID %>");
            var selectedTextCMBRecipient = cmbRecipientType.get_selectedItem().get_text();

            //Hide the checkboxes and controls when Dispostion selected back to select.
            if (isDispositionselectedOnce == 1 && eventArgs.get_item().get_value() == 0) {
                ResetDispositionBelowAllControls();
                $("[id*=cmkCMRScheduled]").removeAttr('checked');
                $("[id*=chkFollowUpAttemptCompleted]").removeAttr('checked');
                $("[id*=chkCMRFollowUp]").removeAttr('checked');
                clearCMROptOutControls();

            }
           
            $("[id*=cmkCMRScheduled]").attr('disabled', false); //13471 iNTERNAL DEFECT
            if (eventArgs.get_item().get_value() != -1 && eventArgs.get_item().get_value() != 0) {
                isDispositionselectedOnce = 1;
                var comboCMROptOut = $find("<%=cmbCMROptOut.ClientID %>");
                var item = eventArgs.get_item();

                //Added for CR-1047.
                var today = new Date();
                var currentYear = today.getFullYear();
                var MinDate = new Date(currentYear, 0, 1);

                if (item.get_value() == "2") { //If Disposition is selected as Patient declined opt out - CMR 
                    $("[id*=divCMROptout]").css('display', 'block');
                    $("[id*=divMTMOptOut]").css('display', 'none');
                    $("[id*=trPharmacists]").css('display', 'none');

                    //Added by surya for CR-1047.
                    $find("<%= RadDateCMROptOutDate.ClientID %>").set_maxDate(today);
                    $find("<%= RadDateCMROptOutDate.ClientID %>").set_minDate(MinDate);

                    hideCMRScheduledSecion(true);
                    hideFollowupScheduledSecion(true);

                    $("[id*=trCheckboxes]").css('display', 'none');
                    $("[id*=divCMRScheduledCheckbox]").css('display', 'none');
                    $("[id*=divFollowupRequiredCheckbox]").css('display', 'none');
                    $("[id*=divFollowupCompletedRequiredCheckbox]").css('display', 'none');

                    //Added for Ticket#16533.
                    document.getElementById("<%=hdnCheckFollowUpAttempts.ClientID%>").value = "0";

                    comboCMROptOut.enable();
                    //HiPAA Logic : show for Call type: Review/Nocall Made and  Inbound voice mail
                    //Removed CallType == 3 for CR-1047.
                    if (CallType == 4) {
                        $("[id*=trHipaa]").css('display', 'none');
                    } else {
                        $("[id*=trHipaa]").css('display', '');
                    }
                    clearMTMOptOutControls();
                }
                else if (item.get_value() == "3") {//If Disposition is selected as Patient declined opt out - MTM
                    var cmbMTMOptOut = $find("<%=cmbMTMOptOut.ClientID %>");
                    var rdOptOutReason_MTM = $find("<%=rdOptOutReason_MTM.ClientID %>");
                    if (rdOptOutReason_MTM.get_selectedItem().get_text() != "Select")
                        rdOptOutReason_MTM.get_element().title = rdOptOutReason_MTM.get_selectedItem().get_text();
                    else
                        rdOptOutReason_MTM.get_element().title = "";

                    var rdReason_MTM = $find("<%=rdReason_MTM.ClientID %>");
                    if (rdReason_MTM.get_selectedItem().get_text() != "Select")
                        rdReason_MTM.get_element().title = rdReason_MTM.get_selectedItem().get_text();
                    else
                        rdReason_MTM.get_element().title = "";

                    //Added by surya for CR-1047.
                    $find("<%= RadDateMTMOptOutDate_MTM.ClientID %>").set_maxDate(today);
                    $find("<%= RadDateMTMOptOutDate_MTM.ClientID %>").set_minDate(MinDate);

                    //Added by surya for CR-1047.
                    $find("<%= rdDateOfDeath.ClientID %>").set_maxDate(today);

                    $("[id*=divCMROptout]").css('display', 'none');
                    $("[id*=divMTMOptOut]").css('display', 'block');
                    /**Clear Checkboxes **/
                    $("[id*=cmkCMRScheduled]").removeAttr('checked');
                    $("[id*=chkFollowUpAttemptCompleted]").removeAttr('checked');
                    $("[id*=chkCMRFollowUp]").removeAttr('checked');
                    $("[id*=trCMRPrescribers]").css('display', 'none');
                    /**End clear checkboxes***/

                    $("[id*=trPharmacists]").css('display', 'none');
                    hideCMRScheduledSecion(true);
                    hideFollowupScheduledSecion(true);

                    $("[id*=trCheckboxes]").css('display', 'none');
                    $("[id*=divCMRScheduledCheckbox]").css('display', 'none');
                    $("[id*=divFollowupRequiredCheckbox]").css('display', 'none');
                    $("[id*=divFollowupCompletedRequiredCheckbox]").css('display', 'none');

                    //Added for Ticket#16533.
                    document.getElementById("<%=hdnCheckFollowUpAttempts.ClientID%>").value = "0";

                    comboCMROptOut.disable();
                    cmbMTMOptOut.enable();
                    clearCMROptOutControls();
                    //HiPAA Logic
                    //Removed CallType == 3 for CR-1047.
                    if (CallType == 4) {
                        $("[id*=trHipaa]").css('display', 'none');
                    } else {
                        $("[id*=trHipaa]").css('display', '');
                    }
                }
                else if (item.get_value() == "4") {//If Disposition is selected as Warm transfer
                    hideCMRScheduledSecion(true);
                    hideFollowupScheduledSecion(true);
                    /**Clear Checkboxes **/
                    $("[id*=cmkCMRScheduled]").removeAttr('checked');
                    $("[id*=chkFollowUpAttemptCompleted]").removeAttr('checked');
                    $("[id*=chkCMRFollowUp]").removeAttr('checked');
                    $("[id*=trCMRPrescribers]").css('display', 'none');
                    /**End clear checkboxes***/

                    //Modified for CR-1047
                    $("[id*=cmkCMRScheduled]").removeAttr('disabled');
                    $("[id*=chkFollowUpAttemptCompleted]").removeAttr('disabled');
                    $("[id*=chkCMRFollowUp]").removeAttr('disabled');

                    $("[id*=trCheckboxes]").css('display', 'none');
                    $("[id*=divCMRScheduledCheckbox]").css('display', 'none');
                    $("[id*=divFollowupRequiredCheckbox]").css('display', 'none');
                    $("[id*=divFollowupCompletedRequiredCheckbox]").css('display', 'none');
                    //Added for Ticket#16533.
                    document.getElementById("<%=hdnCheckFollowUpAttempts.ClientID%>").value = "0";


                    $("[id*=trHipaa]").css('display', '');
                    getPharmacyListCallManagement();
                    $("#MainContent_ucCMRTMR_divCMROptout").css('display', 'none');
                    $("#MainContent_ucCMRTMR_divMTMOptOut").css('display', 'none');
                    comboCMROptOut.disable();

                    $("[id*=divCMROptout]").css('display', 'block');
                    $("[id*=divMTMOptOut]").css('display', 'none');

                    clearCMROptOutControls();
                    clearMTMOptOutControls();


                }
                else if (item.get_value() == "5") {//If Disposition is selected as Invalid phone number

                    hideCMRScheduledSecion(true);
                    hideFollowupScheduledSecion(true);
                    /**Clear Checkboxes **/
                    $("[id*=cmkCMRScheduled]").removeAttr('checked');
                    $("[id*=chkFollowUpAttemptCompleted]").removeAttr('checked');
                    $("[id*=chkCMRFollowUp]").removeAttr('checked');
                    $("[id*=trCMRPrescribers]").css('display', 'none');
                    /**End clear checkboxes***/
                    //$("[id*=trCheckboxes]").css('display', 'none');

                    //Added for CR-1047.
                    if (selectedTextCMBRecipient == 'Other') {
                        $("[id*=trCheckboxes]").css('display', '');
                        $("[id*=divCMRScheduledCheckbox]").css('display', '');
                        $("[id*=divFollowupRequiredCheckbox]").css('display', '');
                        $("[id*=divFollowupCompletedRequiredCheckbox]").css('display', '');

                        //Added for CR-1047.
                        $("[id*=cmkCMRScheduled]").css('display', '');
                        $("[id*=spnCMRScheduled]").css('display', '');
                        $("[id*=chkFollowUpAttemptCompleted]").css('display', '');
                        $("[id*=spnFollowupCompleted]").css('display', '');
                        $("[id*=lblFollowUpCounter]").css('display', '');
                        $("[id*=chkCMRFollowUp]").css('display', '');
                        $("[id*=spnFollowupRequired]").css('display', '');

                        $("[id*=cmkCMRScheduled]").removeAttr('disabled');
                        $("[id*=chkFollowUpAttemptCompleted]").removeAttr('disabled');
                        $("[id*=chkCMRFollowUp]").removeAttr('disabled');
                    }
                    else {
                        $("[id*=trCheckboxes]").css('display', 'none');
                        $("[id*=divCMRScheduledCheckbox]").css('display', 'none');
                        $("[id*=divFollowupRequiredCheckbox]").css('display', 'none');
                        $("[id*=divFollowupCompletedRequiredCheckbox]").css('display', 'none');
                        //Added for Ticket#16533.
                        document.getElementById("<%=hdnCheckFollowUpAttempts.ClientID%>").value = "0";

                    }

                    $("[id*=trHipaa]").css('display', ''); //Enabled HIPAA Verified for CR-1047
                    $("[id*=trPharmacists]").css('display', 'none');

                    $("[id*=divCMROptout]").css('display', 'block');
                    $("[id*=divMTMOptOut]").css('display', 'none');
                    comboCMROptOut.disable();
                    clearCMROptOutControls();
                    clearMTMOptOutControls();

                }
                else if (item.get_value() == "6" || item.get_value() == "7" || item.get_value() == "8") {//If Disposition is selected as Left Message/Left voice mail/ No answer
                    //If Call Type='Inbound voice mail we will show only Checkboxes of CMR scheduled and follow up
                    //If Call type Inbound voice mail and Recipient is pharmacy we wil  hide all controls HIPAA/Follow up required/CMR Scheduled
                    if (CallType == 3) {
                        $("[id*=trHipaa]").css('display', 'none');
                        /**Clear Checkboxes **/
                        $("[id*=cmkCMRScheduled]").removeAttr('checked');
                        $("[id*=chkFollowUpAttemptCompleted]").removeAttr('checked');
                        $("[id*=chkCMRFollowUp]").removeAttr('checked');
                        /**End clear checkboxes***/
                        $("[id*=trCheckboxes]").css('display', '');
                        $("[id*=divCMRScheduledCheckbox]").css('display', '');
                        $("[id*=divFollowupRequiredCheckbox]").css('display', '');
                        $("[id*=divFollowupCompletedRequiredCheckbox]").css('display', '');

                    } else if (CallType == 2) {//IF Call type out bound and Dispostion in Left message/ Left voice/ No Answer No message
                        //Disable CMR Scheduled checkbox, if Call Type outbound and Left message/ Left voice/ No Answer No message


                        $("[id*=trCheckboxes]").css('display', '');
                        /**Clear Checkboxes **/
                        $("[id*=cmkCMRScheduled]").removeAttr('checked');
                        $("[id*=chkFollowUpAttemptCompleted]").removeAttr('checked');
                        $("[id*=chkCMRFollowUp]").removeAttr('checked');
                        $("[id*=chkFollowUpAttemptCompleted]").removeAttr('disabled');
                        /**End clear checkboxes***/

                        $("[id*=cmkCMRScheduled]").css('display', '');
                        $("[id*=spnCMRScheduled]").css('display', '');
                        $("[id*=chkFollowUpAttemptCompleted]").css('display', '');
                        $("[id*=spnFollowupCompleted]").css('display', '');
                        $("[id*=lblFollowUpCounter]").css('display', '');
                        $("[id*=chkCMRFollowUp]").css('display', '');
                        $("[id*=spnFollowupRequired]").css('display', '');


                        $("[id*=divCMRScheduledCheckbox]").css('display', '');
                        $("[id*=divFollowupRequiredCheckbox]").css('display', '');
                        $("[id*=divFollowupCompletedRequiredCheckbox]").css('display', '');
                        $("[id*=trHipaa]").css('display', '');
                        $("[id*=cmkCMRScheduled]").removeAttr('checked');
                        //Added for Ticket#16591
                        $("[id*=chkCMRFollowUp]").attr('disabled', false);
                        // $("[id*=cmkCMRScheduled]").attr('disabled', true);

                        // commented the below code for CR1047 V10.0
                        //Added for CR-1047.
                        //                        if (selectedTextCMBRecipient == 'Other') {
                        //                            $("[id*=cmkCMRScheduled]").attr('disabled', false);
                        //                        }
                        //                        else {
                        //                            $("[id*=cmkCMRScheduled]").attr('disabled', true);
                        //                        }

                    }
                    clearCMROptOutControls();
                    clearMTMOptOutControls();
                    $("[id*=trPharmacists]").css('display', 'none');
                }
                else if (item.get_value() == "11") { // Added for CR-1047.
                    if (CallType == 4) {
                        $("[id*=trHipaa]").css('display', 'none');
                        /**Clear Checkboxes **/
                        $("[id*=cmkCMRScheduled]").removeAttr('checked');
                        $("[id*=chkFollowUpAttemptCompleted]").removeAttr('checked');
                        $("[id*=chkCMRFollowUp]").removeAttr('checked');
                        /**End clear checkboxes***/
                        $("[id*=trCheckboxes]").css('display', 'none');
                        $("[id*=divCMRScheduledCheckbox]").css('display', 'none');
                        $("[id*=divFollowupRequiredCheckbox]").css('display', 'none');
                        $("[id*=divFollowupCompletedRequiredCheckbox]").css('display', 'none');
                        //Added for Ticket#16533.
                        document.getElementById("<%=hdnCheckFollowUpAttempts.ClientID%>").value = "0";
                    }

                    clearCMROptOutControls();
                    clearMTMOptOutControls();
                    $("[id*=trPharmacists]").css('display', 'none');

                }
                else {

                    $("[id*=divCMROptout]").css('display', 'block');
                    $("[id*=divMTMOptOut]").css('display', 'none');
                    $("[id*=trCheckboxes]").css('display', '');
                    /**Clear Checkboxes **/
                    $("[id*=cmkCMRScheduled]").removeAttr('checked');
                    $("[id*=chkFollowUpAttemptCompleted]").removeAttr('checked');
                    $("[id*=chkCMRFollowUp]").removeAttr('checked');
                    /**End clear checkboxes***/

                    //Added for CR-1047.
                    $("[id*=cmkCMRScheduled]").css('display', '');
                    $("[id*=spnCMRScheduled]").css('display', '');
                    $("[id*=chkFollowUpAttemptCompleted]").css('display', '');
                    $("[id*=spnFollowupCompleted]").css('display', '');
                    $("[id*=lblFollowUpCounter]").css('display', '');
                    $("[id*=chkCMRFollowUp]").css('display', '');
                    $("[id*=spnFollowupRequired]").css('display', '');

                    $("[id*=cmkCMRScheduled]").removeAttr('disabled');
                    $("[id*=chkFollowUpAttemptCompleted]").removeAttr('disabled');
                    $("[id*=chkCMRFollowUp]").removeAttr('disabled');

                    hideFollowupScheduledSecion(false);
                    hideCMRScheduledSecion(false);
                    $("[id*=trRecipientOfCMRContactName]").css('display', 'none');
                    $("[id*=trRecipientOfCMRAppointedRep]").css('display', 'none');
                    $("[id*=trRecipientOfCMR]").css('display', 'none');
                    $("[id*=trCMRScheduledDate]").css('display', 'none');
                    $("[id*=trHipaa]").css('display', '');
                    $("[id*=trPharmacists]").css('display', 'none');
                    $("[id*=trLTC]").css('display', '');

                    comboCMROptOut.disable();
                    clearCMROptOutControls();
                    clearMTMOptOutControls();
                }
            }
            // For  Recipient Pharmcy && Dispostion Answer hide all controls
            if (selectedTextCMBRecipient == 'Pharmacy') {
                //$("[id*=trHipaa]").css('display', 'none'); //Commenetd for CR-1047
                $("[id*=trCheckboxes]").css('display', 'none');

                $("[id*=trLTC]").css('display', 'none');
            } else {
                $("[id*=trLTC]").css('display', '');
            }
            
        }
        function ViewMTMTriage() {
            var tempdate = new Date();
            '<%Page.Encrypt(DateTime.Now, true);%>';
            tempdate = '<%=Page.EncryptedValue%>';
            var qsRef = 'MTMTriageLog.aspx<%=Page.QueryStringTokenWithMandatoryQuestionMarkAndOptionalAmpersand%>temp=' + tempdate;
            var manager = $find('RadWindowManagerMTMTriage');
            manager.open(qsRef, "MTMTriageDialog");
            return false;
        }

        function ScheduleCMRAppointment(encryptedCMRScheduledDate) {
            var combo = $find('<%=cmbCMRRecipient.ClientID %>');
            //0503

            var objCMRScheduledDate = $find("<%= RDPCMRScheduledDate.ClientID %>");

            if ($.trim(objCMRScheduledDate._dateInput._text) == "" || $.trim(encryptedCMRScheduledDate) != "") {
                // directly open AddEditAppointment.aspx
                var qsRef = 'AddEditAppointment.aspx<%=Page.QueryStringTokenWithMandatoryQuestionMarkAndOptionalAmpersand%>temp=' + encryptedCMRScheduledDate;
                var manager = $find('RadWindowManagerMTMTriage');
                manager.open(qsRef, "CMRAppointmentScheduler");
                return false;
            }
            else {
                //goto server, encrypt data and open AddEditAppointment.aspx with encrypted CMRScheduledDate
                $("#<%=hdnSelectedCMRScheduleDate.ClientID%>").val($.trim(objCMRScheduledDate._dateInput._text));
                $("#<%=hdnTimeZone.ClientID%>").val($.trim($("#<%=lnkTimeZone.ClientID%>").text()));
                return true;
            }
        }
        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow)
                oWindow = window.radWindow;
            else if (window.frameElement.radWindow)
                oWindow = window.frameElement.radWindow;
            return oWindow;
        }

        //        function changeTriageVendor(CasevendorId) {


        //            var Radwindow = $find('ctl00_MainContent_rdVendorWindow');
        //            Radwindow.close();

        //        }

        function cmbRelationToBeneficiary_MTM_IndexChanged(sender, eventArgs) {
            var item = eventArgs.get_item();
            if (item.get_value() == "7") {
                $find("<%= TxtRelationToBenfeficiaryOther.ClientID %>").clear();
                $("[id*=trOtherRelationToBeneficiary]").css('display', '');
                $("[id*=TxtRelationToBenfeficiaryOther]").removeAttr('disabled');
            }
            else {
                $find("<%= TxtRelationToBenfeficiaryOther.ClientID %>").clear();
                $("[id*=trOtherRelationToBeneficiary]").css('display', 'none');
                $("[id*=TxtRelationToBenfeficiaryOther]").attr('disabled', true);
            }

        }

        function rdOptOutReason_MTM_IndexChanged(sender, eventArgs) {
            var item = eventArgs.get_item();
            if (eventArgs.get_item().get_text() != "Select")
                sender.get_element().title = eventArgs.get_item().get_text();
            else
                sender.get_element().title = "";
            if (item.get_value() == "4") {
                $find("<%= TxtOptOutReasonOther.ClientID %>").clear();
                $("[id*=TxtOptOutReasonOther]").removeAttr('disabled');
            }
            else {
                $find("<%= TxtOptOutReasonOther.ClientID %>").clear();
                $("[id*=TxtOptOutReasonOther]").attr('disabled', true);
            }
            //When we select Opt Out Reason as Death :Date of Death control is enabled
            var rdDateOfDeath = $find("<%=rdDateOfDeath.ClientID %>");
            if (item.get_value() == "1")
            { rdDateOfDeath.set_enabled(true); }
            else {
                rdDateOfDeath.set_enabled(false);
                //Added for Ticket#16518
                rdDateOfDeath.clear();
            }

            //Added for CR-1047.
            var optOutExplanation = $find("<%=rdReason_MTM.ClientID %>");
            //Added for Ticket#16519
            var itm = optOutExplanation.findItemByText('Select');
            itm.select();
            if (item.get_value() == "1" || item.get_value() == "2") {
                optOutExplanation.disable();
            }
            else {
                optOutExplanation.enable();
            }

        }

        function OnCMROptOutClientSelectedIndexChanged(sender, args) {
            var itemText = args.get_item()._text;
            var combo = $find("<%= rdReason.ClientID %>");
            var RadComboOptOutSource = $find("<%= RadComboOptOutSource.ClientID %>");
            var RadDateCMROptOutDate = $find("<%= RadDateCMROptOutDate.ClientID %>");


            if (itemText == 'Yes') {
                combo.enable();
                RadComboOptOutSource.enable();
                //                var itm = combo.findItemByText('Select')
                //                itm.select();
                //                $("[id*=TxtCMRComments]").val('');

                $("[id*=TxtCMRComments]").removeAttr('disabled');
                RadDateCMROptOutDate.set_enabled(true);
                $("[id*=RadDateCMROptOutDate]").attr("disabled", false);

            }
            else {
                var itm = combo.findItemByText('Select');
                itm.select();
                combo.disable();
                var itm_RadComboOptOutSource = RadComboOptOutSource.findItemByText('Select');
                if (itm_RadComboOptOutSource != undefined && itm_RadComboOptOutSource != 'undefined')
                    itm_RadComboOptOutSource.select();
                RadComboOptOutSource.disable();


                $find("<%= TxtCMROtherExplanation.ClientID %>").clear();
                $find("<%= TxtCMROtherSource.ClientID %>").clear();
                $("[id*=TxtCMROtherSource]").attr('disabled', true);
                $("[id*=TxtCMROtherExplanation]").attr('disabled', true);

                $("[id*=TxtCMRComments]").val('');
                $("[id*=TxtCMRComments]").attr('disabled', true);

                RadDateCMROptOutDate.set_enabled(false);
                RadDateCMROptOutDate.clear();
                $("[id*=RadDateCMROptOutDate]").attr("disabled", true);

            }
        }

        function OnMTMOptOutClientSelectedIndexChanged(sender, args) {

            var itemText = args.get_item()._text;
            var combo = $find("<%= rdReason_MTM.ClientID %>");
            var comboReason1 = $find("<%= rdOptOutReason_MTM.ClientID %>");
            var datepicker = $find("<%= RadDateMTMOptOutDate_MTM.ClientID %>");

            var rdDateOfDeath = $find("<%=rdDateOfDeath.ClientID %>");
            if (itemText == 'Yes') {
                combo.disable();
                comboReason1.enable();

                $("[id*=TxtMTMComments]").attr('disabled', false);
                $("[id*=RadDateMTMOptOutDate_MTM]").attr('disabled', false);
                datepicker.set_enabled(true);
                rdDateOfDeath.set_enabled(false);
                $("[id*=rdDuration_MTM]").attr('disabled', false);
                $("[id*=rdDuration_MTM]").removeAttr('disabled');
                $("[id*=rdDuration_MTM]")[1].checked = true;
                //$("[id*=rdDuration_MTM]").val('0');
                //                $('#trDuration').removeClass('DisabledTriage');
                //                $('#trReason').removeClass('EnabledTriage');
                $("[id*=hdnCheck_MTM").val('0');
            }
            else {

                rdDateOfDeath.set_enabled(false);
                rdDateOfDeath.clear();
                var itm_comboReason1 = comboReason1.findItemByValue('0');
                itm_comboReason1.select();
                comboReason1.disable();
                $("[id*=TxtMTMComments]").val('');
                $("[id*=TxtMTMComments]").attr('disabled', true);

                $find("<%= TxtOptOutReasonOther.ClientID %>").clear();
                $find("<%= TxtMTMOtherExplanation.ClientID %>").clear();
                $("[id*=TxtOptOutReasonOther]").attr('disabled', true);
                $("[id*=TxtMTMOtherExplanation]").attr('disabled', true);
                $("[id*=RadDateMTMOptOutDate_MTM]").attr('disabled', true);
                datepicker.set_enabled(false);
                datepicker.clear();
                //datepicker.set_enabled(false);
                $("[id*=rdDuration_MTM]").attr('disabled', true);
                $("[id*=rdDuration_MTM]")[1].checked = false;
                $("[id*=rdDuration_MTM]")[2].checked = false;
                $("[id*=hdnCheck_MTM").val('1');

                //                $('#trDuration').addClass('DisabledTriage');
                //                $('#trReason').addClass('EnabledTriage');

                var itm = combo.findItemByValue('0');
                itm.select();
                combo.disable();
            }
        }
        // Added by srikanth 
        // To set the Effective date to Current date when user change the Patient Impaired information.
        function radCmbPatientImpaired_ClientSelectedIndexChanged(sender, args) {
            var item = args.get_item();
            var itemText = args.get_item()._text;

            var todayDate = new Date("<%= System.DateTime.Today %>");
            var datepickerRadDateCMROptOutDate = $find("<%= RadDateCIEffectiveDate.ClientID %>");
            //datepickerRadDateCMROptOutDate.set_enabled(true);
            if (datepickerRadDateCMROptOutDate.get_selectedDate() == null || datepickerRadDateCMROptOutDate.get_selectedDate() == '')
                datepickerRadDateCMROptOutDate.set_selectedDate(todayDate);
            var sessionUser = $("#<%= hdnSessionUserName.ClientID %>").val();
            $('#<%=lblCISourceValue.ClientID%>').text(sessionUser);
            $('#<%=hdnSourceValue.ClientID%>').val(sessionUser);
        }
        function RadDateCIEffectiveDate_OnDateSelected(sender, e) {

            if (e.get_newDate() != null) {
                var sessionUser = $("#<%= hdnSessionUserName.ClientID %>").val();
                $('#<%=lblCISourceValue.ClientID%>').text(sessionUser);
                $('#<%=hdnSourceValue.ClientID%>').val(sessionUser);

            }
            else {
            }
        }
        function OncmrProvidersClientSelectedIndexChanged(sender, args) {
            var item = args.get_item();
            var itemText = args.get_item()._text;
            if (itemText == 'Other') {
                $("[id*=trCMRPrescriberProviderOther]").css('display', '');

            } else {
                $("[id*=trCMRPrescriberProviderOther]").css('display', 'none');
            }
        }

        function OnProviderClientSelectedIndexChanged(sender, args) {
            var item = args.get_item();
            var itemText = args.get_item()._text;
            if (itemText == 'Other') {
                $("[id*=trOtherPrescriberProvider]").css('display', '');

            } else {
                $("[id*=trOtherPrescriberProvider]").css('display', 'none');
            }
        }
        function OnPrescriberClientSelectedIndexChanged(sender, args) {
            var item = args.get_item();
            var itemText = args.get_item()._text;
            if (itemText == 'Other') {
                $("[id*=trOtherPrescriberProvider]").css('display', '');

            }
            else {
                $("[id*=trOtherPrescriberProvider]").css('display', 'none');
            }
        }
        var isRecipientSelectedOnce = 0;
        function OnRecipientTypeClientSelectedIndexChanged(sender, args) {
            var item = args.get_item();
            var itemText = args.get_item()._text;
            var cmbMTMDisposition = $find("<%=cmbCMDisposition.ClientID %>");
            isDispositionselectedOnce = 0;
            var prefix = document.getElementById('MainContent_hdnPrefix').value.trim();
            var FirstName = document.getElementById('MainContent_hdnFirstName').value.trim();
            var LastName = document.getElementById('MainContent_hdnLastName').value.trim();
            if (itemText == 'Select') 
            clearCMROptOutControls();
            if (prefix == '') prefix = " ";

            if (args.get_item().get_value() != -1 && args.get_item().get_value() != 0) {
                isRecipientSelectedOnce = 1;
            }


            var cmbRelationToBeneficiary_MTM = $find("<%=cmbRelationToBeneficiary_MTM.ClientID %>");
            var itemText = args.get_item()._text;
            if (itemText != 'Select') {

                cmbMTMDisposition.enable();
                var itm_cmbCMDisposition = cmbMTMDisposition.findItemByText('Select');
                itm_cmbCMDisposition.select();
            }
            //Hide the checkboxes and controls when Recipient Type selected back to select.
            if (isRecipientSelectedOnce == 1 && args.get_item().get_value() == 0) {


                var cmbCMDisposition = $find("<%=cmbCMDisposition.ClientID %>");
                cmbCMDisposition.enable();
                var itm_cmbCMDisposition = cmbCMDisposition.findItemByText('Select');
                itm_cmbCMDisposition.select();
                cmbCMDisposition.disable();

            }

            ResetAllControlsAndHide();
            $("[id*=cmkCMRScheduled]").removeAttr('checked');
            $("[id*=chkFollowUpAttemptCompleted]").removeAttr('checked');
            $("[id*=chkCMRFollowUp]").removeAttr('checked');

            var datepicker = $find("<%= RDPCMRScheduledDate.ClientID %>");
            datepicker.clear();

            if (itemText == "Beneficiary's Prescriber") {
                $("[id*=MainContent_ucCMRTMR_trContactName]").css('display', 'none');
                $("[id*=MainContent_ucCMRTMR_trRelationToBeneficiary]").css('display', 'none');
                $("[id*=MainContent_ucCMRTMR_trAppointedRep]").css('display', 'none');
                $("[id*=trOtherRelationToBeneficiary]").css('display', 'none');
                getPrescribersListCallManagement(1);
            } else if (itemText == "Pharmacy") {
                $("[id*=MainContent_ucCMRTMR_trContactName]").css('display', 'none');
                $("[id*=MainContent_ucCMRTMR_trRelationToBeneficiary]").css('display', 'none');
                $("[id*=MainContent_ucCMRTMR_trAppointedRep]").css('display', 'none');
                $("[id*=trOtherRelationToBeneficiary]").css('display', 'none');
                getPrescribersListCallManagement(2);
            } else if (itemText == "Caregiver" || itemText == "Other Authorized Individual") {
                $("[id*=MainContent_ucCMRTMR_trContactName]").css('display', 'none');
                $("[id*=MainContent_ucCMRTMR_trAppointedRep]").css('display', '');
                $("[id*=MainContent_ucCMRTMR_trRelationToBeneficiary]").css('display', '');
                $("[id*=trPrescribersList]").css('display', 'none');
                $("[id*=trProviders]").css('display', 'none');
                $("[id*=trOtherPrescriberProvider]").css('display', 'none');
                cmbRelationToBeneficiary_MTM.enable();
                var itm_cmbCMRelation = cmbRelationToBeneficiary_MTM.findItemByText('Select');
                itm_cmbCMRelation.select();

            } else if (itemText == "Beneficiary" || itemText == "Other") { //Added 'Other' condition for CR-1047.
                $("[id*=MainContent_ucCMRTMR_trContactName]").css('display', '');
                $("[id*=MainContent_ucCMRTMR_trRelationToBeneficiary]").css('display', 'none');
                $("[id*=MainContent_ucCMRTMR_trAppointedRep]").css('display', 'none');
                $("[id*=trPrescribersList]").css('display', 'none');
                $("[id*=trProviders]").css('display', 'none');
                $("[id*=trOtherPrescriberProvider]").css('display', 'none');
                $("[id*=trOtherRelationToBeneficiary]").css('display', 'none');

                //If and else consition added for CR-1047.
                if (itemText == "Beneficiary") {
                    $("[id*=txtContactPrefix]").val(prefix);
                    $("[id*=txtContactFirstName]").val(FirstName);
                    $("[id*=txtContactLastName]").val(LastName);

                    $("[id*=txtCMRContactPrefix]").val(prefix);
                    $("[id*=txtCMRContactFirstName]").val(FirstName);
                    $("[id*=txtCMRContactLastName]").val(LastName);
                }
                else {
                    $("[id*=txtContactPrefix]").val('');
                    $("[id*=txtContactFirstName]").val('');
                    $("[id*=txtContactLastName]").val('');

                    $("[id*=txtCMRContactPrefix]").val('');
                    $("[id*=txtCMRContactFirstName]").val('');
                    $("[id*=txtCMRContactLastName]").val('');
                }

            }

            var isCMRScheduled = $("[id*=cmkCMRScheduled]").is(':checked');
            var ischkCMRFollowUp = $("[id*=chkCMRFollowUp]").is(':checked');
            if (isCMRScheduled || ischkCMRFollowUp) {

                var itemText = args.get_item()._text;
                var cmbRecipientType = $find("<%=cmbRecipientType.ClientID %>");
                var cmbCMRRecipient = $find("<%=cmbCMRRecipient.ClientID %>");
                var selectedTextCMBRecipient = cmbRecipientType.get_selectedItem().get_text();
                var selectedTextCMRCMBRecipient = cmbCMRRecipient.get_selectedItem().get_text();
                selectedTextCMRCMBRecipient = selectedTextCMRCMBRecipient.replace(/[0-9]/g, '');
                selectedTextCMRCMBRecipient = selectedTextCMRCMBRecipient.replace('-', '').trim();
                // validateRecipientOfCMR();
                validateRecipientOfCMRCombobox(selectedTextCMBRecipient, selectedTextCMRCMBRecipient);

            }

            var combo_cmbMTMCallType = $find("<%=cmbMTMCallType.ClientID %>");
            var CallType = combo_cmbMTMCallType.get_selectedItem().get_text();
            if (CallType != 'Select') {
                getDispositionTypes(CallType, itemText);
            }



        }
        var CallTypeSelectedOnce = 0;
        function OnClientCallTypeSelectedIndexChanged(sender, args) {

            var itemText = args.get_item()._text;
            var cmbMTMRecipient = $find("<%=cmbRecipientType.ClientID %>");
            var selectedTextCMRCMBRecipient = cmbMTMRecipient.get_selectedItem().get_text();
            //Hide the checkboxes and controls when Dispostion selected back to select.
            if (CallTypeSelectedOnce == 1 && args.get_item().get_value() == 0) {

            }
            if (itemText != 'Select') {
                //Reset form again when call type changed.
                CallTypeSelectedOnce = 1;
                getDispositionTypes(itemText, selectedTextCMRCMBRecipient);
                cmbMTMRecipient.enable();
                if (itemText == 'Review/No call made') {
                    $("[id*=trRecipientType]").css('display', 'none');
                    $("[id*=trHipaa]").css('display', 'none');
                    // $("[id*=MainContent_ucCMRTMR_trLTC]").css('display', 'none'); --CR420 FRD Version 5.00
                }
                else if (itemText == 'Inbound-Voicemail') {
                    $("[id*=trRecipientType]").css('display', '');
                    $("[id*=trHipaa]").css('display', 'none');
                }
                else {
                    $("[id*=trRecipientType]").css('display', '');
                    $("[id*=trHipaa]").css('display', '');
                    // $("[id*=MainContent_ucCMRTMR_trLTC]").css('display', '');--CR420 FRD Version 5.00
                }

                var cmbRecipientType = $find("<%=cmbRecipientType.ClientID %>");
                var itm_cmbRecipientType = cmbRecipientType.findItemByText('Select');
                itm_cmbRecipientType.select();

                var cmbCMDisposition = $find("<%=cmbCMDisposition.ClientID %>");
                cmbCMDisposition.enable();
                var itm_cmbCMDisposition = cmbCMDisposition.findItemByText('Select');
                itm_cmbCMDisposition.select();

                ResetAllControlsAndHide();
            }


        }
        function ResetAllControlsAndHide() {
            $("[id*=MainContent_ucCMRTMR_trRelationToBeneficiary]").css('display', 'none');
            $("[id*=MainContent_ucCMRTMR_trAppointedRep]").css('display', 'none');
            $("[id*=trRecipientOfCMRContactName]").css('display', 'none');
            $("[id*=MainContent_ucCMRTMR_trContactName]").css('display', 'none');
            $("[id*=trRecipientOfCMRAppointedRep]").css('display', 'none');
            $("[id*=MainContent_ucCMRTMR_trRecipientOfCMR]").css('display', 'none');
            $("[id*=trCMRPrescribers]").css('display', 'none');
            $("[id*=trProviders]").css('display', 'none');
            $("[id*=trPrescribersList]").css('display', 'none');
            $("[id*=divCMROptout]").css('display', 'block');
            $("[id*=divMTMOptOut]").css('display', 'none');
            //$("[id*=trLTC]").css('display', '');

            //Added for Ticket#16515 - Set CMR Default Values
            $("[id*=TxtCMROtherExplanation]").val('');
            $("[id*=TxtCMROtherSource]").val('');
            $("[id*=TxtCMRComments]").val('');

            var cmbCMROptOut = $find("<%=cmbCMROptOut.ClientID %>");
            var dtCMROptOutDate = $find("<%=RadDateCMROptOutDate.ClientID %>");
            var ddlOptOutInformationSource = $find("<%=RadComboOptOutSource.ClientID %>");
            var ddlOptOutReason = $find("<%=rdReason.ClientID %>");

            var optOutSelection = cmbCMROptOut.findItemByText('No');
            optOutSelection.select();
            dtCMROptOutDate.clear();
            var optOutInfoirmationSourceSelect = ddlOptOutInformationSource.findItemByText('Select');
            optOutInfoirmationSourceSelect.select();
            var optOutReasonSelect = ddlOptOutReason.findItemByText('Select');
            optOutReasonSelect.select();

            //Added for Ticket#16515 - Set MTM Default Values
            $("[id*=TxtOptOutReasonOther]").val('');
            $("[id*=TxtMTMOtherExplanation]").val('');
            $("[id*=TxtMTMComments]").val('');

            var cmbMTMOptOut = $find("<%=cmbMTMOptOut.ClientID %>");
            var dtMTMOptOutDate = $find("<%=RadDateMTMOptOutDate_MTM.ClientID %>");
            var dtMTMDateOfDeath = $find("<%=rdDateOfDeath.ClientID %>");
            var ddlMTMOptOutReason = $find("<%=rdOptOutReason_MTM.ClientID %>");
            var ddlMTMReason = $find("<%=rdReason_MTM.ClientID %>");

            var mtmOptOutSelection = cmbMTMOptOut.findItemByText('No');
            mtmOptOutSelection.select();
            dtMTMOptOutDate.clear();
            dtMTMDateOfDeath.clear();
            var mtmReasonSelection = ddlMTMOptOutReason.findItemByText('Select');
            mtmReasonSelection.select();
            var mtmSourceSelection = ddlMTMReason.findItemByText('Select');
            mtmSourceSelection.select();


            /** First Hide all Above section controls(Recipient)**/
            $("[id*=MainContent_ucCMRTMR_trContactName]").css('display', 'none');
            $("[id*=trRecipientOfCMRContactName]").css('display', 'none');
            $("[id*=MainContent_ucCMRTMR_trAppointedRep]").css('display', 'none');
            $("[id*=trProviders]").css('display', 'none');
            $("[id*=trPrescribersList]").css('display', 'none');
            $("[id*=trOtherPrescriberProvider]").css('display', 'none');
            $("[id*=trOtherRelationToBeneficiary]").css('display', 'none');


            /**First Hide all below section controls(Recipient of CMR)**/
            $("[id*=trCMRPrescribers]").css('display', 'none');
            $("[id*=trCMRProviders]").css('display', 'none');
            $("[id*=trRecipientOfCMRContactName]").css('display', 'none');
            $("[id*=trRecipientOfCMRAppointedRep]").css('display', 'none');
            $("[id*=MainContent_ucCMRTMR_trCMRPrescriberProviderOther]").css('display', 'none');


            hideCMRScheduledSecion(true);
            hideFollowupScheduledSecion(true);
            $("[id*=trCheckboxes]").css('display', 'none');
            $("[id*=trPharmacists]").css('display', 'none');
        }
        function ResetDispositionBelowAllControls() {

            // $("[id*=MainContent_ucCMRTMR_trAppointedRep]").css('display', 'none');
            $("[id*=trRecipientOfCMRContactName]").css('display', 'none');

            $("[id*=trRecipientOfCMRAppointedRep]").css('display', 'none');
            $("[id*=MainContent_ucCMRTMR_trRecipientOfCMR]").css('display', 'none');
            $("[id*=trCMRPrescribers]").css('display', 'none');


            $("[id*=divCMROptout]").css('display', 'block');
            $("[id*=divMTMOptOut]").css('display', 'none');
            //$("[id*=trLTC]").css('display', '');


            /** First Hide all Above section controls(Recipient)**/

            $("[id*=trRecipientOfCMRContactName]").css('display', 'none');
            // $("[id*=MainContent_ucCMRTMR_trAppointedRep]").css('display', 'none');
            //$("[id*=trProviders]").css('display', 'none');
            //$("[id*=trPrescribersList]").css('display', 'none');

            /**First Hide all below section controls(Recipient of CMR)**/
            $("[id*=trCMRPrescribers]").css('display', 'none');
            $("[id*=trCMRProviders]").css('display', 'none');
            $("[id*=trRecipientOfCMRContactName]").css('display', 'none');
            $("[id*=trRecipientOfCMRAppointedRep]").css('display', 'none');
            $("[id*=MainContent_ucCMRTMR_trCMRPrescriberProviderOther]").css('display', 'none');


            hideCMRScheduledSecion(true);
            hideFollowupScheduledSecion(true);
            $("[id*=trCheckboxes]").css('display', 'none');
            $("[id*=trPharmacists]").css('display', 'none');
        }

        var isUnReachable = false;
        function OnClientSelectedIndexChanged(sender, args) {
            // To get the item
            var item = args.get_item();
            //To get the item text
            var itemText = args.get_item()._text;
            var FirstName;
            var LastName;
            var prefix;
            var chkAttemptsChecked = false;

            //            var txtprefix = $find("<%= txtContactPrefix.ClientID %>");
            //            var txtFirstName = $find("<%= txtContactFirstName.ClientID %>");
            //            var txtLastName = $find("<%= txtContactLastName.ClientID %>");


            if (sender.get_text().toLowerCase().trim() == "unreachable") {
                var chkFollowUpAttemptCompleted = $("[id*=chkFollowUpAttemptCompleted]").prop('checked');
                isUnReachable = true;

                //                ClearMTMControlsOnConfirm();
                //                DisableMTMControls();
                ClearMTMControlsOnConfirmWithoutPatientImpairedInfo();
                DisableMTMControlsWithoutPatientImapredSection();
                isUnReachable = false;
                return false;
            }
            else {
                isUnReachable = false;
                EnableMTMControls();
                var chkFollowUpAttemptCompleted = $("[id*=chkFollowUpAttemptCompleted]").prop('checked');
                if (chkFollowUpAttemptCompleted) {
                    chkAttemptsChecked = true;
                    DisableControlsWhenChkAttemptsIsChecked();
                }

            }
            var datepicker2 = $find("<%=rdDateOfDeath.ClientID %>");
            datepicker2.set_enabled(false);

            if (itemText.toUpperCase() == "BENEFICIARY") {
                prefix = document.getElementById('MainContent_hdnPrefix').value.trim();
                FirstName = document.getElementById('MainContent_hdnFirstName').value.trim();
                LastName = document.getElementById('MainContent_hdnLastName').value.trim();

                if (prefix == '') prefix = " ";

                $("[id*=txtContactPrefix]").val(prefix);
                $("[id*=txtContactFirstName]").val(FirstName);
                $("[id*=txtContactLastName]").val(LastName);

            }
            else if (itemText.toUpperCase() == "BENEFICIARY'S PRESCRIBER") {
                prefix = document.getElementById('MainContent_hdnPrimaryPreFix').value.trim();
                FirstName = document.getElementById('MainContent_hdnPrimaryFirstName').value.trim();
                LastName = document.getElementById('MainContent_hdnPrimaryLastName').value.trim();

                if (prefix == '') prefix = " ";

                $("[id*=txtContactPrefix]").val(prefix);
                $("[id*=txtContactFirstName]").val(FirstName);
                $("[id*=txtContactLastName]").val(LastName);

            } else {
                $("[id*=txtContactPrefix]").val('');
                $("[id*=txtContactFirstName]").val('');
                $("[id*=txtContactLastName]").val('');
            }
            var chkFollowUp = "<%= chkCMRFollowUp.ClientID %>";
            if (!chkAttemptsChecked)
                checkFollowUp(document.getElementById(chkFollowUp));

        }
        function DisableControlsWhenChkAttemptsIsChecked() {

            $("[id*=chkCMRFollowUp]").removeAttr('checked');
            $("[id*=chkCMRFollowUp]").attr('disabled', true);



            var combo = $find("<%= cmbCMROptOut.ClientID %>");
            var itm = combo.findItemByValue('0');
            itm.select();
            combo.disable();
            var cmbMTMOptOut = $find("<%= cmbMTMOptOut.ClientID %>");
            var itm1 = cmbMTMOptOut.findItemByValue('0');
            itm1.select();
            cmbMTMOptOut.disable();
            //            combo = $find("<%= cmbPatientImpaired.ClientID %>");
            //            itm = combo.findItemByValue('3');
            //            itm.select();
            //            combo.disable();
            combo = $find("<%= cmbCMRRecipient.ClientID %>");
            itm = combo.findItemByValue('0');
            itm.select();
            combo.disable();

            var datepicker = $find("<%= RDPCMRScheduledDate.ClientID %>");
            datepicker.clear();
            datepicker.set_enabled(false);

            $("[id*=lnkScheduleAppointment]").attr('disabled', true);
            $("[id*=lnkScheduleAppointment]").css('color', '#767676');
            $("[id*=lnkScheduleAppointment]").css('cursor', 'default');
        }
        function PreviewTemplateInNewWindow() {
            //window.open("../showpdf.aspx<%=QueryStringTokenWithQuestionMark%>", "MTMPDFPreview", "height=800,width=900,modal=yes,alwaysRaised=yes,resizable=1");
            EditTemplateInNewWindow(); // temporary
        }

        function EditTemplateInNewWindow() {
            window.open("EditLetter.aspx<%=QueryStringTokenWithQuestionMark%>", "MTMEditTemplate", "height=800,width=900,modal=yes,alwaysRaised=yes,resizable=1");
        }
        function scrollBrowserTop() {
            document.body.scrollTop = document.documentElement.scrollTop = 0
        }

        function RedirectToQM() {
            var url = window.location.href.substring(0, window.location.href.lastIndexOf("/"));
            var n = url.lastIndexOf("/");
            url = url.substring(0, n + 1) + "QueueManager/QueueManager.aspx<%=QueryStringTokenWithQuestionMark%>";
            window.parent.location = url;
        }
        function CloseOptOutWindow() {
            var chkFollowUp = "<%= chkCMRFollowUp.ClientID %>";
            if (document.getElementById(chkFollowUp).checked) {

                var combo = $find("<%= cmbCMROptOut.ClientID %>");
                var itm = combo.findItemByValue('0');
                itm.select();
                combo.disable();
                //                combo = $find("<%= cmbPatientImpaired.ClientID %>");
                //                itm = combo.findItemByValue('3');
                //                itm.select();
                combo.disable();
                combo = $find("<%= cmbCMRRecipient.ClientID %>");
                itm = combo.findItemByValue('0');
                itm.select();
                combo.disable();


                var datepicker = $find("<%= RDPCMRScheduledDate.ClientID %>");
                datepicker.clear();
                datepicker.set_enabled(false);
            }
            else {

                var combo = $find("<%= cmbCMROptOut.ClientID %>");
                combo.enable();
                combo = $find("<%= cmbPatientImpaired.ClientID %>");
                combo.enable();
                combo = $find("<%= cmbCMRRecipient.ClientID %>");
                combo.enable();

                var datepicker = $find("<%= RDPCMRScheduledDate.ClientID %>");
                datepicker.set_enabled(true);
            }
            var oWnd = $find("<%= rwPreCMR.ClientID %>");
            oWnd.Close();
        }
        function CloseRadWindowForValidation() {
            var oWnd = $find("<%= RadWindowForValidation.ClientID %>");
            oWnd.Close();
        }
        function CloseRadWindowForValidation1() {
            var oWnd = $find("<%= RadWindowForValidation1.ClientID %>");
            oWnd.Close();
        }

        var partialClickFromSave = false;
        function clientSaveMTMTriage(sender, args) {
            var ischkCMRFollowUpChecked = $("[id*=chkCMRFollowUp]").prop('checked');
            var ischkCMRScheduled = $("[id*=cmkCMRScheduled]").prop('checked');

            var ischkFollowUpAttemptCompletedChecked = $("[id*=chkFollowUpAttemptCompleted]").prop('checked');

            var objCMRScheduledDate = $find("<%= RDPCMRScheduledDate.ClientID %>");

            //0503
            //            if (cmbPersonContacted.get_selectedItem().get_value().trim() == "0" && !isFollowUpRequired) {
            //                radalert('Person contacted is required.', 400, 150, 'Validation');
            //                sender.set_autoPostBack(false);
            //                return false;


            //            }
            if (partialClickFromSave) {
                sender.set_autoPostBack(true);
                return false;
            }

            var optOut = false;
            var mtmPotOut = false;
            var chkFollowUp = "<%= chkCMRFollowUp.ClientID %>";
            var chkFollowUpAttemptCompleted = "<%= chkFollowUpAttemptCompleted.ClientID %>";
            var combo = $find("<%= cmbCMROptOut.ClientID %>");
            var cmbMTMOptOut = $find("<%=cmbMTMOptOut.ClientID %>");

            var itm = combo.findItemByValue('0');
            var isFollowUpRequired = document.getElementById(chkFollowUp).checked;
            var RDPCMRScheduledDate = $find("<%= RDPCMRScheduledDate.ClientID %>");

            //Added for CR-1047
            var mtmComments = $("[id*=txtMTMTriageComments]").val();
            var reWhiteSpace = new RegExp(/^\s+$/);

            var txtContactFirstNameval = $("[id*=txtContactFirstName]").val().trim();
            var txtContactLastNameval = $("[id*=txtContactLastName]").val().trim();

            var combo_cmbCMROptOut = $find("<%=cmbCMROptOut.ClientID %>");
            var combo_cmbMTMOptOut = $find("<%=cmbMTMOptOut.ClientID %>");
            var combo_cmbCMDisposition = $find("<%=cmbCMDisposition.ClientID %>");
            var combo_cmbRecipientType = $find("<%=cmbRecipientType.ClientID %>");
            var combo_cmbMTMCallType = $find("<%=cmbMTMCallType.ClientID %>");

            var combo_cmbPrescribers = $find("<%=cmbPrescribers.ClientID %>");
            var combo_cmbProviders = $find("<%=cmbProviders.ClientID %>");
            var combo_cmbPharmacist = $find("<%=cmbPharmacist.ClientID %>");

            var txtOtherPrescriberProviderFirst = $("[id*=txtOtherPrescriberProvider2]").val().trim();
            var txtOtherPrescriberProviderLastNme = $("[id*=txtOtherPrescriberProvider3]").val().trim();

            // Check for white space
            //Added for CR-1047
            if (reWhiteSpace.test(mtmComments)) {
                radalert('Please enter comments in correct format.', 400, 150, 'Validation');
                sender.set_autoPostBack(false);
                return false;
            }


            if (combo.get_selectedItem().get_text().trim() == "Yes" && combo_cmbCMDisposition.get_selectedItem().get_text().trim() == 'Patient Declined/Opt Out - CMR') optOut = true;
            if (cmbMTMOptOut.get_selectedItem().get_text().trim() == "Yes" && combo_cmbCMDisposition.get_selectedItem().get_text().trim() == 'Patient Declined/Opt Out - MTM Program') mtmPotOut = true;

            if (combo_cmbMTMCallType.get_selectedItem().get_value() == 0) {
                radalert('Please select Call Type', 400, 150, 'Validation');
                sender.set_autoPostBack(false);
                return false;
            } else if (combo_cmbRecipientType.get_selectedItem().get_value() == 0 && combo_cmbMTMCallType.get_selectedItem().get_value() != 4) {

                radalert('Please select Recipient Type', 400, 150, 'Validation');
                sender.set_autoPostBack(false);
                return false;
            }
            else if (combo_cmbRecipientType.get_selectedItem().get_value() != 0) {
                //Validate the Recipient type field
                //Validate Recipient type Beneficiary

                // Or condition added for CR-1047.
                if (combo_cmbRecipientType.get_selectedItem().get_value() == 1 || combo_cmbRecipientType.get_selectedItem().get_value() == 6) {

                    var txtContactFirstNameval = $("[id*=txtContactFirstName]").val();
                    var txtContactLastNameval = $("[id*=txtContactLastName]").val();


                    //Added for CR-1047.
                    var txtPrefix = $("[id*=txtContactPrefix]").val();

                    // Check for white space
                    //Added for CR-1047
                    //                    if (reWhiteSpace.test(txtPrefix)) {
                    //                        radalert('Please enter prefix in correct format.', 400, 150, 'Validation');
                    //                        sender.set_autoPostBack(false);
                    //                        return false;
                    //                    }

                    //Added for CR-1047
                    if (reWhiteSpace.test(txtContactFirstNameval)) {
                        radalert('Please enter first name in correct format.', 400, 150, 'Validation');
                        sender.set_autoPostBack(false);
                        return false;
                    }

                    //Added for CR-1047
                    if (reWhiteSpace.test(txtContactLastNameval)) {
                        radalert('Please enter last name in correct format.', 400, 150, 'Validation');
                        sender.set_autoPostBack(false);
                        return false;
                    }

                    if (combo_cmbRecipientType.get_selectedItem().get_value() == 1) {
                        if (txtContactFirstNameval == '' || txtContactLastNameval == '') {
                            radalert('Please enter Recipient Name', 400, 150, 'Validation');
                            sender.set_autoPostBack(false);
                            return false;
                        }
                    }

                    if (combo_cmbRecipientType.get_selectedItem().get_value() == 6) {
                        if (txtContactFirstNameval == '' && txtContactLastNameval == '' && txtPrefix == '') {
                            radalert('Please enter Recipient Name', 400, 150, 'Validation');
                            sender.set_autoPostBack(false);
                            return false;
                        }
                    }


                } else if (combo_cmbRecipientType.get_selectedItem().get_value() == 2) {//Validate Recipient type Beneficiary Prescriber

                    if (combo_cmbPrescribers.get_selectedItem().get_value() == 0) {
                        radalert('Please select Prescriber', 400, 150, 'Validation');
                        sender.set_autoPostBack(false);
                        return false;
                    } else if (combo_cmbPrescribers.get_selectedItem().get_value() == -1) {
                        if (txtOtherPrescriberProviderFirst == '' || txtOtherPrescriberProviderLastNme == '') {
                            radalert('Please enter Other Name', 400, 150, 'Validation');
                            sender.set_autoPostBack(false);
                            return false;

                        }
                    }

                }
                else if (combo_cmbRecipientType.get_selectedItem().get_value() == 4 || combo_cmbRecipientType.get_selectedItem().get_value() == 3) {//Validate Recipient type Care Giver/ Other Authorized

                    var TxtRelationToBenfeficiaryOther = $find("<%= TxtRelationToBenfeficiaryOther.ClientID %>").get_value().trim();
                    var cmbRelationToBeneficiary_MTM = $find("<%=cmbRelationToBeneficiary_MTM.ClientID %>");
                    var labelAppointedRepresentative = document.getElementById('<%=lblPatientRepName.ClientID%>').innerHTML;

                    var itemValue = cmbRelationToBeneficiary_MTM.get_selectedItem().get_value();
                    if (itemValue == 0) {
                        radalert('Please select Relation to Beneficiary', 400, 150, 'Validation');
                        sender.set_autoPostBack(false);
                        return false;
                    } else if (itemValue == 7 && TxtRelationToBenfeficiaryOther == '') {
                        radalert('Please enter Other Relation to Beneficiary', 400, 150, 'Validation');
                        sender.set_autoPostBack(false);
                        return false;
                    }
                    if (labelAppointedRepresentative == 'No Appointed Rep') {
                        radalert('Please add Appointed representative', 400, 150, 'Validation');
                        sender.set_autoPostBack(false);
                        return false;
                    }

                }
                else if (combo_cmbRecipientType.get_selectedItem().get_value() == 5) {//Validate Recipient type Beneficiary Pharmacy
                    if (combo_cmbProviders.get_selectedItem().get_value() == 0) {
                        radalert('Please select Pharmacy', 400, 150, 'Validation');
                        sender.set_autoPostBack(false);
                        return false;
                    } else if (combo_cmbProviders.get_selectedItem().get_value() == -1) {
                        if (txtOtherPrescriberProviderFirst == '' || txtOtherPrescriberProviderLastNme == '') {
                            radalert('Please enter Other Name', 400, 150, 'Validation');
                            sender.set_autoPostBack(false);
                            return false;

                        }
                    }


                }

            }
            if (combo_cmbCMDisposition.get_selectedItem().get_value() == 0) {
                radalert('Please select Disposition Type', 400, 150, 'Validation');
                sender.set_autoPostBack(false);
                return false;
            }

            //Dispostion type validation
            if (combo_cmbCMDisposition.get_selectedItem().get_value() != 0) {
                if (combo_cmbCMDisposition.get_selectedItem().get_text().trim() == 'Warm Transfer') { //If Warm transfer selected Pharmacist-
                    //-Selection is mandatory
                    if (combo_cmbPharmacist.get_selectedItem().get_value() == 0) {
                        radalert('Please select a Pharmacist', 400, 150, 'Validation');
                        sender.set_autoPostBack(false);
                        return false;
                    }

                } else if (combo_cmbCMDisposition.get_selectedItem().get_text().trim() == 'Patient Declined/Opt Out - CMR') {
                    if (combo_cmbCMROptOut.get_selectedItem().get_value() == 0) {
                        radalert('Please select CMR Opt Out Yes', 400, 150, 'Validation');
                        sender.set_autoPostBack(false);
                        return false;
                    }
                } else if (combo_cmbCMDisposition.get_selectedItem().get_text().trim() == 'Patient Declined/Opt Out - MTM Program') {

                    if (combo_cmbMTMOptOut.get_selectedItem().get_value() == 0) {
                        radalert('Please select MTM Opt Out Yes', 400, 150, 'Validation');
                        sender.set_autoPostBack(false);
                        return false;
                    }

                }
            }


            //Added for CR-1047
            if (combo_cmbMTMCallType.get_selectedItem().get_value() == 4 && combo_cmbCMDisposition.get_selectedItem().get_value() == 11) {

                if (mtmComments == '') {
                    radalert('Please enter comments.', 400, 150, 'Validation');
                    sender.set_autoPostBack(false);
                    return false;
                }
            }

            var ischeckboxeshidden = $("[id*=trCheckboxes]").is(":hidden");

            //$("[id*=trCheckboxes]").css('display', 'none');

            if (combo_cmbCMROptOut.get_selectedItem().get_value().trim() != "1" && combo_cmbMTMOptOut.get_selectedItem().get_value().trim() != "1") {
                if (((combo_cmbCMDisposition.get_selectedItem().get_text().trim() != 'Warm Transfer' &&
                   combo_cmbCMDisposition.get_selectedItem().get_text().trim() != 'Invalid Phone Number' &&
                  (ischkCMRFollowUpChecked == false && ischkCMRScheduled == false && ischkFollowUpAttemptCompletedChecked == false)) ||
				  ((ischkCMRFollowUpChecked == false && ischkCMRScheduled == false && ischkFollowUpAttemptCompletedChecked == false) &&
				  (combo_cmbCMDisposition.get_selectedItem().get_text().trim() != 'Left Message'))) && (!ischeckboxeshidden)) {
                    //When CMR Scheduled is disabled show other validation pop up.
                    var ischkCMRScheduledDisabled = $("[id*=cmkCMRScheduled]").prop('disabled');
                    if (ischkCMRScheduledDisabled) {
                        var rdWindow1 = $find('<%=RadWindowForValidation1.ClientID %>');
                        rdWindow1.show();
                        sender.set_autoPostBack(false);
                        return false;
                    } else {
                        var rdWindow = $find('<%=RadWindowForValidation.ClientID %>');
                        rdWindow.show();
                        sender.set_autoPostBack(false);
                        return false;
                    }
                }
                else {
                    //If minimum one Checkbox selected, validate for Recipient and Date.
                    //Add validation of Recipient Name/ Folow up with below.
                    var validation = validateRecipientWhileSaving();
                    if (validation != '') {

                        radalert(validation, 400, 150, 'Validation');
                        sender.set_autoPostBack(false);
                        return false;
                    }

                }

            }

            var isCMRScheduled = $("[id*=cmkCMRScheduled]").is(':checked');
            var comboCMRRecipient = $find("<%= cmbCMRRecipient.ClientID %>");
            var dateValidationMessage = '';

            var isFollowupRequired = $("[id*=chkCMRFollowUp]").is(':checked');
            /***Not Required
            if (isCMRScheduled) {
            dateValidationMessage = 'Please select CMR Scheduled date';
            } else if (isFollowupRequired) {
            dateValidationMessage = 'Please select Follow up Scheduled date';
            }
            if (isCMRScheduled || isFollowupRequired) {
            if (comboCMRRecipient.get_selectedItem().get_value() == 0 || RDPCMRScheduledDate.get_selectedDate() == null) {
            radalert(dateValidationMessage);
            sender.set_autoPostBack(false);
            return false;
            } 
            }
            ***/

            if (optOut && !mtmPotOut) {
                var RadDateCMROptOutDate = $find("<%=RadDateCMROptOutDate.ClientID %>");

                //Modified the message for CR-1047.
                if (RadDateCMROptOutDate.get_selectedDate() == null || RadDateCMROptOutDate.get_selectedDate() == undefined || RadDateCMROptOutDate.get_selectedDate() == 'undefined' || RadDateCMROptOutDate.get_selectedDate() == "") {
                    radalert("CMR Opt Out Date is either not entered or is invalid.", 400, 150, 'Validation');
                    sender.set_autoPostBack(false);
                    return false;
                }

                //Added for CR-1047.
                var RadComboOptOutSource = $find("<%=RadComboOptOutSource.ClientID %>");
                if (RadComboOptOutSource.get_selectedItem().get_value().trim() == "0") {
                    radalert("Opt Out Information Source is required.", 400, 150, 'Validation');
                    sender.set_autoPostBack(false);
                    return false;
                }

                //Added for CR-1047.
                var optOutOtherSource = document.getElementById("<%= TxtCMROtherSource.ClientID %>");
                if (RadComboOptOutSource.get_selectedItem().get_value().trim() == "3" && optOutOtherSource.value == '') {
                    radalert("Opt Out other Source is required.", 400, 150, 'Validation');
                    sender.set_autoPostBack(false);
                    return false;
                }
                else {
                    if (reWhiteSpace.test(optOutOtherSource.value)) {
                        radalert('Please enter CMR Opt Out Other Source in correct format.', 400, 150, 'Validation');
                        sender.set_autoPostBack(false);
                        return false;
                    }
                }

                //Added for CR-1047.
                var rdReason = $find("<%=rdReason.ClientID %>");
                var optOutOtherExplanation = document.getElementById("<%= TxtCMROtherExplanation.ClientID %>");
                if (rdReason.get_selectedItem().get_value().trim() == "8" && optOutOtherExplanation.value == '') {
                    radalert("Opt Out other explanation is required.", 400, 150, 'Validation');
                    sender.set_autoPostBack(false);
                    return false;
                }
                else {
                    if (reWhiteSpace.test(optOutOtherExplanation.value)) {
                        radalert('Please enter CMR Opt Out Other Explanation in correct format.', 400, 150, 'Validation');
                        sender.set_autoPostBack(false);
                        return false;
                    }
                }

            }

            if (mtmPotOut) {
                var rdOptOutReason_MTM = $find("<%= rdOptOutReason_MTM.ClientID %>");
                var rdDateOfDeath = $find("<%= rdDateOfDeath.ClientID %>");


                //Added for CR-1047.
                var rdReason_MTM = $find("<%=rdReason_MTM.ClientID %>");
                var optOutOtherExplanation_MTM = document.getElementById("<%= TxtMTMOtherExplanation.ClientID %>");
                var txtOptOutOtherReason = document.getElementById("<%= TxtOptOutReasonOther.ClientID %>")

                if (rdOptOutReason_MTM.get_selectedItem().get_value().trim() == "1") {
                    //                    if (rdDateOfDeath.get_selectedDate() == null || rdDateOfDeath.get_selectedDate() == undefined || rdDateOfDeath.get_selectedDate() == 'undefined' || rdDateOfDeath.get_selectedDate() == "") {
                    //                        radalert("Date Of Death is required.", 400, 150, 'Validation');
                    //                        sender.set_autoPostBack(false);
                    //                        return false;
                    //                    }
                }
                var RadDateMTMOptOutDate_MTM = $find("<%=RadDateMTMOptOutDate_MTM.ClientID %>");

                //Modified message for CR-1047.
                if (RadDateMTMOptOutDate_MTM.get_selectedDate() == null || RadDateMTMOptOutDate_MTM.get_selectedDate() == undefined || RadDateMTMOptOutDate_MTM.get_selectedDate() == 'undefined' || RadDateMTMOptOutDate_MTM.get_selectedDate() == "") {
                    radalert("MTM Opt Out Date is either not entered or is invalid.", 400, 150, 'Validation');
                    sender.set_autoPostBack(false);
                    return false;
                }

                //Added for CR-1047
                var mtmDateOfDeath = rdDateOfDeath.get_dateInput().get_value();

                if (!rdDateOfDeath.get_dateInput()._holdsValidValue) {

                    radalert("Date of death is invalid.", 400, 150, 'Validation');
                    sender.set_autoPostBack(false);
                    return false;

                }

                if (rdOptOutReason_MTM.get_selectedItem() == null || rdOptOutReason_MTM.get_selectedItem() == undefined || rdOptOutReason_MTM.get_selectedItem() == 'undefined' || rdOptOutReason_MTM.get_selectedItem().get_value() == 0) {
                    radalert("Opt Out Reason is required.", 400, 150, 'Validation');
                    sender.set_autoPostBack(false);
                    return false;
                }

                //Added for CR-1047.               
                if (rdOptOutReason_MTM.get_selectedItem().get_value().trim() == "4" && txtOptOutOtherReason.value == '') {
                    radalert("Opt Out other reason is required.", 400, 150, 'Validation');
                    sender.set_autoPostBack(false);
                    return false;
                }
                else {
                    if (reWhiteSpace.test(txtOptOutOtherReason.value)) {
                        radalert('Please enter MTM Opt Out other reason in correct format.', 400, 150, 'Validation');
                        sender.set_autoPostBack(false);
                        return false;
                    }
                }

                //Added for CR-1047.
                if (rdOptOutReason_MTM.get_selectedItem().get_value().trim() == "3" && (rdReason_MTM.get_selectedItem() == null || rdReason_MTM.get_selectedItem().get_value() == "0")) {
                    radalert("Opt Out explanation is required.", 400, 150, 'Validation');
                    sender.set_autoPostBack(false);
                    return false;
                }

                //Added for CR-1047.
                if (rdReason_MTM.get_selectedItem().get_value().trim() == "8" && optOutOtherExplanation_MTM.value == '') {
                    radalert("Opt Out other explanation is required.", 400, 150, 'Validation');
                    sender.set_autoPostBack(false);
                    return false;
                }
                else {
                    if (reWhiteSpace.test(optOutOtherExplanation_MTM.value)) {
                        radalert('Please enter MTM Opt Out other explanation in correct format.', 400, 150, 'Validation');
                        sender.set_autoPostBack(false);
                        return false;
                    }
                }
            }

            if (optOut && mtmPotOut) {
                var rdWindow = $find('<%=rdConfirmSave.ClientID %>');
                document.getElementById("<%= spnConfirmSave.ClientID %>").innerHTML = 'You selected to opt out from CMR and MTM Program. Do you want to continue?';
                rdWindow.show();
                sender.set_autoPostBack(false);
                return false;
            }
            else if (mtmPotOut) {
                var rdWindow = $find('<%=rdConfirmSave.ClientID %>');
                document.getElementById("<%= spnConfirmSave.ClientID %>").innerHTML = 'You selected to opt out from MTM Program. This action will opt out from CMR as well. Do you want to continue?';
                rdWindow.show();
                sender.set_autoPostBack(false);
                return false;
            }
            else if (optOut) {
                var rdWindow = $find('<%=rdConfirmSave.ClientID %>');
                document.getElementById("<%= spnConfirmSave.ClientID %>").innerHTML = 'You selected to opt out from CMR. Do you want to continue?';
                rdWindow.show();
                sender.set_autoPostBack(false);
                return false;
            }
            else {
                //confirm('All changes are final, please click on OK to move to next step.');
                // mtmFieldsModified = false;
                MTMTriage_Modified = 0;
                sender.set_autoPostBack(true);
            }

            //            var validated = Page_ClientValidate('preCMR');
            //            if (validated) {
            //                if (!confirm('All changes are final, please click on OK to move to next step.'))
            //                    return false;
            //                else
            //                    return true;
            //            }
            //            else return false
        }
        function MTMalertCallBackFn(arg) {
            return false;
        }

        function ContinueCMRMTMSave() {

            var rdWindow = $find('<%=rdConfirmSave.ClientID %>');
            rdWindow.close();
            partialClickFromSave = true;
            var combo = $find("<%= cmbCMROptOut.ClientID %>");
            var cmbMTMOptOut = $find("<%=cmbMTMOptOut.ClientID %>");
            if (cmbMTMOptOut.get_selectedItem().get_text() == "Yes") {
                itm = combo.findItemByValue('1');
                itm.select();
            }
            document.getElementById('<%=btnSaveMTMTriage.ClientID%>').click();
            partialClickFromSave = false;
        }

        function CheckedChangeTriage(objCheckBox) {

            if (objCheckBox.checked) {

                var hdnFormat = document.getElementById("<%= hdnFormat.ClientID %>");
                var controlId = hdnFormat.Value;
                var control = document.getElementById(controlId.toString());
                control.firstChild.data = objCheckBox.nextSibling.innerHTML;
                var hdnTimeZone = document.getElementById("<%= hdnTimeZone.ClientID %>");
                hdnTimeZone.value = objCheckBox.nextSibling.innerHTML;
            }

        }

        function lnkNextFollowupDateClickTriage(sender) {

            var SourceId = sender.id;
            var hdnFormat = document.getElementById("<%= hdnFormat.ClientID %>");
            hdnFormat.Value = SourceId;
        }
        function lnkNextFollowupDateClickTriageFollowUp(sender) {

            var SourceId = sender.id;
            var hdnFormat = document.getElementById("<%= hdnFormatFollowUp.ClientID %>");
            hdnFormat.Value = SourceId;
        }
        function CheckedChangeTriageFollowUp(objCheckBox) {
            if (objCheckBox.checked) {

                var hdnFormat = document.getElementById("<%= hdnFormatFollowUp.ClientID %>");
                var controlId = hdnFormat.Value;
                var control = document.getElementById(controlId.toString());
                control.firstChild.data = objCheckBox.nextSibling.innerHTML;
                var hdnTimeZone = document.getElementById("<%= hdnTimeZoneFollowUp.ClientID %>");
                hdnTimeZone.value = objCheckBox.nextSibling.innerHTML;
            }

        }

        function DisableMTMControls() {
            //uncommented
            // $('#divMtmTriage').find('input, textarea, select').attr('disabled', true);
            //

            $("[id*=txtContactPrefix]").attr('disabled', true);
            $("[id*=txtContactFirstName]").attr('disabled', true);
            $("[id*=txtContactLastName]").attr('disabled', true);
            $("[id*=chkCMRFollowUp]").attr('disabled', true);
            $("[id*=chkFollowUpAttemptCompleted]").attr('disabled', true);

            $("[id*=RadDateMTMOptOutDate_MTM]").attr('disabled', true);
            $("[id*=RadDateCMROptOutDate]").attr('disabled', true);


            $("[id*=btnAssignCaseVendor]").removeAttr('disabled');
            $("[id*=btnClosePopup]").removeAttr('disabled');

            $("[id*=lnkScheduleAppointment]").attr('disabled', true);
            $("[id*=lnkScheduleAppointment]").css('color', '#767676');
            $("[id*=lnkScheduleAppointment]").css('cursor', 'default');

            $("[id*=lnkChangeRecpientName]").attr('disabled', true);

            $("[id*=lnkChangeRecpientName]").css('color', '#767676');
            $("[id*=lnkChangeRecpientName]").css('cursor', 'default');

            $("[id*=lnkCMRChangeRecpientName]").attr('disabled', true);

            $("[id*=lnkCMRChangeRecpientName]").css('color', '#767676');
            $("[id*=lnkCMRChangeRecpientName]").css('cursor', 'default');


            $("#lnkViewEditBIMS").attr('disabled', true);
            $("#lnkViewEditBIMS").css('color', '#767676');
            $("#lnkViewEditBIMS").css('cursor', 'default');

            $("[id*=txtCMRContactPrefix]").attr('disabled', true);
            $("[id*=txtCMRContactFirstName]").attr('disabled', true);
            $("[id*=txtCMRContactLastName]").attr('disabled', true);

            $("[id*=txtMTMTriageComments]").attr('disabled', true);

            var RadDateMTMOptOutDate_MTM = $find("<%=RadDateMTMOptOutDate_MTM.ClientID %>");
            if (RadDateMTMOptOutDate_MTM != undefined && RadDateMTMOptOutDate_MTM != 'undefined') {
                RadDateMTMOptOutDate_MTM.set_enabled(false);
            }
            else {
                return false;
            }

            var rdDateOfDeath = $find("<%=rdDateOfDeath.ClientID %>");
            rdDateOfDeath.set_enabled(false);

            var RDPCMRScheduledDate = $find("<%=RDPCMRScheduledDate.ClientID %>");
            RDPCMRScheduledDate.set_enabled(false);
            //0503 CR420 - Start

            var cmbMTMCallType = $find("<%=cmbMTMCallType.ClientID %>");
            cmbMTMCallType.disable();
            var cmbMTMRecipient = $find("<%=cmbRecipientType.ClientID %>");
            cmbMTMRecipient.disable();

            var cmbMTMDisposition = $find("<%=cmbCMDisposition.ClientID %>");
            cmbMTMDisposition.disable();
            $("[id*=chkCMHIPAAVerified]").attr('disabled', true);
            // CR1047 V10.0
            $("[id*=cmkCMRScheduled]").attr('disabled', true);

            var cmbPrescribers = $find("<%=cmbPrescribers.ClientID %>");
            cmbPrescribers.disable();

            var cmrPrescribers = $find("<%=cmrPrescribers.ClientID %>");
            cmrPrescribers.disable();

            var cmbProviders = $find("<%=cmbProviders.ClientID %>");
            cmbProviders.disable();

            var cmbPharmacist = $find("<%=cmbPharmacist.ClientID %>");
            cmbPharmacist.disable();


            $("[id*=txtOtherPrescriberProvider1]").attr('disabled', true);
            $("[id*=txtOtherPrescriberProvider2]").attr('disabled', true);
            $("[id*=txtOtherPrescriberProvider3]").attr('disabled', true);
            $("[id*=txtSubOtherNPI1]").attr('disabled', true);
            $("[id*=txtSubOtherNPI2]").attr('disabled', true);
            $("[id*=txtSubOtherNPI3]").attr('disabled', true);





            //0503 CR420 - End


            var cmbCMRRecipient = $find("<%=cmbCMRRecipient.ClientID %>");
            cmbCMRRecipient.disable();

            var cmbCMROptOut = $find("<%=cmbCMROptOut.ClientID %>");
            cmbCMROptOut.disable();


            var cmbPatientImpaired = $find("<%=cmbPatientImpaired.ClientID %>");
            cmbPatientImpaired.disable();

            var cmbLTCIndicator = $find("<%=cmbLTCIndicator.ClientID %>");
            cmbLTCIndicator.disable();


            var cmbPatientImpaired = $find("<%=cmbPatientImpaired.ClientID %>");
            cmbPatientImpaired.disable();

            var PatientImpairedEDate = $find("<%=RadDateCIEffectiveDate.ClientID %>");
            PatientImpairedEDate.set_enabled(false);

            //if (cmbCMROptOut.get_selectedItem().get_value() == "1") {

            //                var datepickerRadDateCMROptOutDate = $find("<%=RadDateCMROptOutDate.ClientID %>");
            //                datepickerRadDateCMROptOutDate.set_enabled(true);

            //                var rdReason = $find("<%= rdReason.ClientID %>");
            //                rdReason.enable();

            //                $("[id*=TxtCMRComments]").removeAttr('disabled');
            //                $("[id*=rdDuration]").removeAttr('disabled');

            //            }
            //            else {
            var datepickerRadDateCMROptOutDate = $find("<%=RadDateCMROptOutDate.ClientID %>");
            datepickerRadDateCMROptOutDate.set_enabled(false);

            var rdReason = $find("<%= rdReason.ClientID %>");
            if (rdReason.get_selectedItem().get_text() != "Select")
                rdReason.get_element().title = rdReason.get_selectedItem().get_text();
            else
                rdReason.get_element().title = "";
            rdReason.disable();
            var RadComboOptOutSource = $find("<%= RadComboOptOutSource.ClientID %>");
            RadComboOptOutSource.disable();

            $("[id*=TxtCMROtherExplanation]").attr('disabled', true);
            $("[id*=TxtCMROtherSource]").attr('disabled', true);

            $("[id*=TxtCMRComments]").attr('disabled', true);
            $("[id*=rdDuration]").attr('disabled', true);
            $("[id*=TxtMTMOtherExplanation]").attr('disabled', true);

            var cmbMTMOptOut = $find("<%=cmbMTMOptOut.ClientID %>");
            cmbMTMOptOut.disable();

            var rdOptOutReason_MTM = $find("<%= rdOptOutReason_MTM.ClientID %>");
            rdOptOutReason_MTM.disable();
            if (rdOptOutReason_MTM.get_selectedItem().get_text() != "Select")
                rdOptOutReason_MTM.get_element().title = rdOptOutReason_MTM.get_selectedItem().get_text();
            else
                rdOptOutReason_MTM.get_element().title = "";
            var rdReason_MTM = $find("<%= rdReason_MTM.ClientID %>");
            rdReason_MTM.disable();
            if (rdReason_MTM.get_selectedItem().get_text() != "Select")
                rdReason_MTM.get_element().title = rdReason_MTM.get_selectedItem().get_text();
            else
                rdReason_MTM.get_element().title = "";


            $("[id*=TxtMTMComments]").attr('disabled', true);
            $("[id*=TxtRelationToBenfeficiaryOther]").attr('disabled', true);
            $("[id*=TxtOptOutReasonOther]").attr('disabled', true);
            $("[id*=rdDuration_MTM]").attr('disabled', true);

            //}

            var datepickerRadDateCMROptOutDate = $find("<%=RadDateCMROptOutDate.ClientID %>");
            datepickerRadDateCMROptOutDate.set_enabled(false);


            var cmbCMRRecipient = $find("<%=cmbCMRRecipient.ClientID %>");
            var cmbRelationToBeneficiary_MTM = $find("<%=cmbRelationToBeneficiary_MTM.ClientID %>");
            //            if (cmbCMRRecipient.get_selectedItem().get_value() > "1")
            //                cmbRelationToBeneficiary_MTM.enable();
            //            else
            cmbRelationToBeneficiary_MTM.disable();

            if (isUnReachable != true) {
                $find("<%=btnCancelMTMTriage.ClientID %>").set_enabled(false);
                $find("<%=btnSaveMTMTriage.ClientID %>").set_enabled(false);
            }
            if (isInvalidPhoneNumberChecked) {
                $find("<%=btnCancelMTMTriage.ClientID %>").set_enabled(true);
                $find("<%=btnSaveMTMTriage.ClientID %>").set_enabled(true);
            }
        }

        function DisableMTMControlsWithoutPatientImapredSection() {
            //uncommented
            // $('#divMtmTriage').find('input, textarea, select').attr('disabled', true);
            //

            $("[id*=txtContactPrefix]").attr('disabled', true);
            $("[id*=txtContactFirstName]").attr('disabled', true);
            $("[id*=txtContactLastName]").attr('disabled', true);
            $("[id*=chkCMRFollowUp]").attr('disabled', true);
            $("[id*=chkFollowUpAttemptCompleted]").attr('disabled', true);

            $("[id*=RadDateMTMOptOutDate_MTM]").attr('disabled', true);
            $("[id*=RadDateCMROptOutDate]").attr('disabled', true);






            if (isUnReachable != true) {
                $("[id*=txtMTMTriageComments]").attr('disabled', true);
            }


            if (isInvalidPhoneNumberChecked) {
                $("[id*=txtMTMTriageComments]").removeAttr('disabled');
                //                $("[id*=txtContactPrefix]").removeAttr('disabled');
                //                $("[id*=txtContactFirstName]").removeAttr('disabled');
                //                $("[id*=txtContactLastName]").removeAttr('disabled');

            }




            $("[id*=btnAssignCaseVendor]").removeAttr('disabled');
            $("[id*=btnClosePopup]").removeAttr('disabled');

            $("[id*=lnkScheduleAppointment]").attr('disabled', true);
            $("[id*=lnkScheduleAppointment]").css('color', '#767676');
            $("[id*=lnkScheduleAppointment]").css('cursor', 'default');

            $("[id*=lnkChangeRecpientName]").attr('disabled', true);

            $("[id*=lnkChangeRecpientName]").css('color', '#767676');
            $("[id*=lnkChangeRecpientName]").css('cursor', 'default');

            $("[id*=lnkCMRChangeRecpientName]").attr('disabled', true);
            $("[id*=lnkCMRChangeRecpientName]").css('color', '#767676');
            $("[id*=lnkCMRChangeRecpientName]").css('cursor', 'default');

            $("#lnkViewEditBIMS").attr('disabled', true);
            $("#lnkViewEditBIMS").css('color', '#767676');
            $("#lnkViewEditBIMS").css('cursor', 'default');

            var RadDateMTMOptOutDate_MTM = $find("<%=RadDateMTMOptOutDate_MTM.ClientID %>");
            if (RadDateMTMOptOutDate_MTM != undefined && RadDateMTMOptOutDate_MTM != 'undefined') {
                RadDateMTMOptOutDate_MTM.set_enabled(false);
            }
            else {
                return false;
            }

            var rdDateOfDeath = $find("<%=rdDateOfDeath.ClientID %>");
            rdDateOfDeath.set_enabled(false);

            var RDPCMRScheduledDate = $find("<%=RDPCMRScheduledDate.ClientID %>");
            RDPCMRScheduledDate.set_enabled(false);
            //0503

            //            var cmbCMRRecipient = $find("<%=cmbCMRRecipient.ClientID %>");
            //            cmbCMRRecipient.disable();

            //            var cmbPatientImpaired = $find("<%=cmbPatientImpaired.ClientID %>");
            //            cmbPatientImpaired.disable();

            //            var cmbPatientImpaired = $find("<%=cmbPatientImpaired.ClientID %>");
            //            cmbPatientImpaired.disable();

            //            var PatientImpairedEDate = $find("<%=RadDateCIEffectiveDate.ClientID %>");
            //            PatientImpairedEDate.set_enabled(false);

            //if (cmbCMROptOut.get_selectedItem().get_value() == "1") {

            //                var datepickerRadDateCMROptOutDate = $find("<%=RadDateCMROptOutDate.ClientID %>");
            //                datepickerRadDateCMROptOutDate.set_enabled(true);

            //                var rdReason = $find("<%= rdReason.ClientID %>");
            //                rdReason.enable();

            //                $("[id*=TxtCMRComments]").removeAttr('disabled');
            //                $("[id*=rdDuration]").removeAttr('disabled');

            //            }
            //            else {
            var datepickerRadDateCMROptOutDate = $find("<%=RadDateCMROptOutDate.ClientID %>");
            datepickerRadDateCMROptOutDate.set_enabled(false);

            var rdReason = $find("<%= rdReason.ClientID %>");
            rdReason.disable();
            var RadComboOptOutSource = $find("<%= RadComboOptOutSource.ClientID %>");
            RadComboOptOutSource.disable();


            $("[id*=TxtCMROtherExplanation]").attr('disabled', true);
            $("[id*=TxtCMROtherSource]").attr('disabled', true);

            $("[id*=TxtCMRComments]").attr('disabled', true);
            $("[id*=rdDuration]").attr('disabled', true);
            $("[id*=TxtMTMOtherExplanation]").attr('disabled', true);

            var cmbMTMOptOut = $find("<%=cmbMTMOptOut.ClientID %>");
            cmbMTMOptOut.disable();

            var rdOptOutReason_MTM = $find("<%= rdOptOutReason_MTM.ClientID %>");
            rdOptOutReason_MTM.disable();

            var rdReason_MTM = $find("<%= rdReason_MTM.ClientID %>");
            rdReason_MTM.disable();
            $("[id*=TxtMTMComments]").attr('disabled', true);
            $("[id*=TxtRelationToBenfeficiaryOther]").attr('disabled', true);
            $("[id*=TxtOptOutReasonOther]").attr('disabled', true);
            $("[id*=rdDuration_MTM]").attr('disabled', true);

            //}

            var datepickerRadDateCMROptOutDate = $find("<%=RadDateCMROptOutDate.ClientID %>");
            datepickerRadDateCMROptOutDate.set_enabled(false);


            var cmbCMRRecipient = $find("<%=cmbCMRRecipient.ClientID %>");
            var cmbRelationToBeneficiary_MTM = $find("<%=cmbRelationToBeneficiary_MTM.ClientID %>");
            //            if (cmbCMRRecipient.get_selectedItem().get_value() > "1")
            //                cmbRelationToBeneficiary_MTM.enable();
            //            else
            cmbRelationToBeneficiary_MTM.disable();

            if (isUnReachable != true) {
                $find("<%=btnCancelMTMTriage.ClientID %>").set_enabled(false);
                $find("<%=btnSaveMTMTriage.ClientID %>").set_enabled(false);
            }
            if (isInvalidPhoneNumberChecked) {
                $find("<%=btnCancelMTMTriage.ClientID %>").set_enabled(true);
                $find("<%=btnSaveMTMTriage.ClientID %>").set_enabled(true);
            }
        }
        function EnableMTMControls_ClientClick(sender, args) {
            //  $('#divMtmTriage').find('input, textarea, button, select').attr('disabled', false);
            $("[id*=txtContactPrefix]").removeAttr('disabled');
            $("[id*=txtContactFirstName]").removeAttr('disabled');
            $("[id*=txtContactLastName]").removeAttr('disabled');
            $("[id*=chkCMRFollowUp]").removeAttr('disabled');
            $("[id*=chkFollowUpAttemptCompleted]").removeAttr('disabled');

            $("[id*=lnkScheduleAppointment]").removeAttr('disabled');
            $("[id*=lnkScheduleAppointment]").css('color', '#0101DF');
            $("[id*=lnkScheduleAppointment]").css('cursor', 'pointer');

            $("[id*=lnkChangeRecpientName]").removeAttr('disabled');
            $("[id*=lnkChangeRecpientName]").css('color', '#0101DF');
            $("[id*=lnkChangeRecpientName]").css('cursor', 'pointer');

            $("[id*=lnkCMRChangeRecpientName]").removeAttr('disabled');
            $("[id*=lnkCMRChangeRecpientName]").css('color', '#0101DF');
            $("[id*=lnkCMRChangeRecpientName]").css('cursor', 'pointer');

            $("#lnkViewEditBIMS").removeAttr('disabled');
            $("#lnkViewEditBIMS").css('color', '#0101DF');
            $("#lnkViewEditBIMS").css('cursor', 'pointer');
            $("[id*=txtMTMTriageComments]").removeAttr('disabled');
            $("[id*=txtCMRContactPrefix]").removeAttr('disabled');
            $("[id*=txtCMRContactFirstName]").removeAttr('disabled');
            $("[id*=txtCMRContactLastName]").removeAttr('disabled');


            var combo4 = $find("<%=cmbCMROptOut.ClientID %>");
            /**CR 420
            combo4.enable();
            **/
            if (combo4.get_selectedItem().get_value() == "1") {

                var datepickerRadDateCMROptOutDate = $find("<%=RadDateCMROptOutDate.ClientID %>");
                datepickerRadDateCMROptOutDate.set_enabled(true);

                var combo8 = $find("<%= rdReason.ClientID %>");
                combo8.enable();

                var RadComboOptOutSource = $find("<%= RadComboOptOutSource.ClientID %>");
                RadComboOptOutSource.enable();

                $("[id*=TxtCMRComments]").removeAttr('disabled');
                $("[id*=rdDuration]").removeAttr('disabled');

            }
            else {
                $("[id*=TxtCMRComments]").attr('disabled', true);
                $("[id*=rdDuration]").attr('disabled', true);

            }

            var combo5 = $find("<%=cmbMTMOptOut.ClientID %>");
            combo5.enable();
            if (combo5.get_selectedItem().get_value() == "1") {
                var datepicker = $find("<%=RadDateMTMOptOutDate_MTM.ClientID %>");
                datepicker.set_enabled(true);

                var combo6 = $find("<%= rdOptOutReason_MTM.ClientID %>");
                combo6.enable();

                var combo7 = $find("<%= rdReason_MTM.ClientID %>");
                combo7.enable();

                $("[id*=TxtMTMComments]").removeAttr('disabled');
                $("[id*=rdDuration_MTM]").removeAttr('disabled');

            }
            else {
                $("[id*=TxtMTMComments]").attr('disabled', true);
                $("[id*=rdDuration_MTM]").attr('disabled', true);

            }

            var datepicker1 = $find("<%=RDPCMRScheduledDate.ClientID %>");
            datepicker1.set_enabled(true);

            var combo1 = $find("<%=cmbCMRRecipient.ClientID %>");
            combo1.enable();

            var cmbRelationToBeneficiary_MTM = $find("<%=cmbRelationToBeneficiary_MTM.ClientID %>");

            if (combo1.get_selectedItem().get_value() > "1")
                cmbRelationToBeneficiary_MTM.enable();
            else
                cmbRelationToBeneficiary_MTM.disable();

            var datepicker2 = $find("<%=rdDateOfDeath.ClientID %>");
            datepicker2.set_enabled(true);

            //0503

            var combo2 = $find("<%=cmbPatientImpaired.ClientID %>");
            combo2.enable();




            //            $("[id*=btnSaveMTMTriage]").css('display', '');
            //            $("[id*=btnCancelMTMTriage]").css('display', '');
            //            $("[id*=btnClearMTMTriage]").css('display', '');
            //            $("[id*=btnEditMTMTriage]").css('display', 'none');
            return false;
        }
        function ClearMTMControls_ClientClick(sender, args) {
            MTMTriage_Modified = 1;
            $find("<%=btnCancelMTMTriage.ClientID %>").set_enabled(true);
            $find("<%=btnSaveMTMTriage.ClientID %>").set_enabled(true);
            $find("<%=btnClearMTMTriage.ClientID %>").set_enabled(false);


            var chkAttempts = false;
            if ($("[id*=chkFollowUpAttemptCompleted]").prop('checked') == true) {
                chkAttempts = true;
            }
            // ClearMTMControlsOnConfirm();
            ClearMTMControlsOnConfirmWithoutPatientImpairedInfo();
            //            var cmbMTMRecipient = $find("<%=cmbRecipientType.ClientID %>");
            //            var itm_cmbCMRRecipient = cmbMTMRecipient.findItemByText('Select');
            //            alert(cmbMTMRecipient.SelectedItem);
            //            alert(itm_cmbCMRRecipient);
            //            if (itm_cmbCMRRecipient) {
            //                itm_cmbCMRRecipient.select();
            //            }


            //            if (chkAttempts && $("[id*=hdnFollowUpCounter]").val() >= "3") {
            //                $("[id*=ChkInvalidPhoneNumber]").attr('disabled', true);
            //                $("[id*=chkCMRFollowUp]").attr('disabled', true);
            //                $("[id*=rdppreCMRFollowUpDate]").attr('disabled', true);
            //                $("[id*=chkFollowUpAttemptCompleted]").attr('disabled', true);
            //                return;
            //            }

            //            if ($("[id*=hdnFollowUpCounter]").val() >= "3") {
            //                //$("[id*=chkCMRFollowUp]").removeAttr('checked');
            //                $("[id*=chkCMRFollowUp]").attr('disabled', true);
            //                $("[id*=rdppreCMRFollowUpDate]").attr('disabled', true);
            //                //                $("[id*=chkFollowUpAttemptCompleted]").removeAttr('checked');
            //                //                $("[id*=chkFollowUpAttemptCompleted]").removeAttr('disabled');
            //                $("[id*=ChkInvalidPhoneNumber]").attr('disabled', true);
            //            }

        }
        var partialClickFromCancel = false;
        function btnCancelMTMTriage_ClientClick(sender, args) {
            if (partialClickFromCancel) {
                sender.set_autoPostBack(true);
                return false;
            }
            var rdWindow = $find('<%=rdConfirmWindowForClear.ClientID %>');
            rdWindow.show();
            sender.set_autoPostBack(false);
            return false;
        }

        function CancelMTMChangesOnConfirm() {
            partialClickFromCancel = true;
            MTMTriage_Modified = 0;
            var rdWindow = $find('<%=rdConfirmWindowForClear.ClientID %>');
            rdWindow.close();
            document.getElementById('<%=btnCancelMTMTriage.ClientID%>').click();
            partialClickFromCancel = false;

        }

        function EnableMTMControls() {
            //$('#divMtmTriage').find('input, textarea, button, select').attr('disabled', false);

            $("[id*=txtContactPrefix]").removeAttr('disabled');
            $("[id*=txtContactFirstName]").removeAttr('disabled');
            $("[id*=txtContactLastName]").removeAttr('disabled');
            $("[id*=chkCMRFollowUp]").removeAttr('disabled');
            $("[id*=chkFollowUpAttemptCompleted]").removeAttr('disabled');
            $("[id*=txtMTMTriageComments]").removeAttr('disabled');
            $("[id*=txtCMRContactPrefix]").removeAttr('disabled');
            $("[id*=txtCMRContactFirstName]").removeAttr('disabled');
            $("[id*=txtCMRContactLastName]").removeAttr('disabled');

            $("[id*=lnkScheduleAppointment]").removeAttr('disabled');
            $("[id*=lnkScheduleAppointment]").css('color', '#0101DF');
            $("[id*=lnkScheduleAppointment]").css('cursor', 'pointer');

            $("[id*=lnkChangeRecpientName]").removeAttr('disabled');
            $("[id*=lnkChangeRecpientName]").css('color', '#0101DF');
            $("[id*=lnkChangeRecpientName]").css('cursor', 'pointer');

            $("[id*=lnkCMRChangeRecpientName]").removeAttr('disabled');
            $("[id*=lnkCMRChangeRecpientName]").css('color', '#0101DF');
            $("[id*=lnkCMRChangeRecpientName]").css('cursor', 'pointer');

            $("#lnkViewEditBIMS").removeAttr('disabled');
            $("#lnkViewEditBIMS").css('color', '#0101DF');
            $("#lnkViewEditBIMS").css('cursor', 'pointer');

            $("[id*=btnAssignCaseVendor]").removeAttr('disabled');
            $("[id*=btnClosePopup]").removeAttr('disabled');

            $("[id*=txtMTMTriageComments]").removeAttr('disabled');

            var combo4 = $find("<%=cmbCMROptOut.ClientID %>");
            /***CR 420
            combo4.enable();
            ***/
            if (combo4.get_selectedItem().get_value() == "1") {

                var datepickerRadDateCMROptOutDate = $find("<%=RadDateCMROptOutDate.ClientID %>");
                datepickerRadDateCMROptOutDate.set_enabled(true);
                $("[id*=RadDateCMROptOutDate]").removeAttr('disabled');

                var combo8 = $find("<%= rdReason.ClientID %>");
                combo8.enable();

                var RadComboOptOutSource = $find("<%= RadComboOptOutSource.ClientID %>");
                RadComboOptOutSource.enable();

                $("[id*=TxtCMRComments]").removeAttr('disabled');
                $("[id*=rdDuration]").removeAttr('disabled');

                var datepicker2 = $find("<%=rdDateOfDeath.ClientID %>");
                datepicker2.set_enabled(true);

            }
            else {
                $("[id*=TxtCMRComments]").attr('disabled', true);
                $("[id*=rdDuration]").attr('disabled', true);

            }

            var combo5 = $find("<%=cmbMTMOptOut.ClientID %>");
            combo5.enable();
            if (combo5.get_selectedItem().get_value() == "1") {
                var datepicker = $find("<%=RadDateMTMOptOutDate_MTM.ClientID %>");
                datepicker.set_enabled(true);
                $("[id*=RadDateMTMOptOutDate_MTM]").removeAttr('disabled');

                var combo6 = $find("<%= rdOptOutReason_MTM.ClientID %>");
                combo6.enable();

                var combo7 = $find("<%= rdReason_MTM.ClientID %>");
                combo7.enable();

                $("[id*=TxtMTMComments]").removeAttr('disabled');
                $("[id*=rdDuration_MTM]").removeAttr('disabled');

            }
            else {
                $("[id*=TxtMTMComments]").attr('disabled', true);
                $("[id*=rdDuration_MTM]").attr('disabled', true);

            }

            var datepicker1 = $find("<%=RDPCMRScheduledDate.ClientID %>");
            datepicker1.set_enabled(true);

            var combo1 = $find("<%=cmbCMRRecipient.ClientID %>");
            combo1.enable();

            var cmbRelationToBeneficiary_MTM = $find("<%=cmbRelationToBeneficiary_MTM.ClientID %>");
            if (combo1.get_selectedItem().get_value() > "1")
                cmbRelationToBeneficiary_MTM.enable();
            else
                cmbRelationToBeneficiary_MTM.disable();

            var datepicker2 = $find("<%=rdDateOfDeath.ClientID %>");
            datepicker2.set_enabled(true);
            //0503
            var combo2 = $find("<%=cmbPatientImpaired.ClientID %>");
            combo2.enable();


            var datepickerED = $find("<%=RadDateCIEffectiveDate.ClientID %>");
            datepickerED.set_enabled(true);

            var cmbCMRRecipient = $find("<%=cmbCMRRecipient.ClientID %>");
            cmbCMRRecipient.enable();

            var cmbMTMCallType = $find("<%=cmbMTMCallType.ClientID %>");
            cmbMTMCallType.enable();

            var cmbMTMRecipient = $find("<%=cmbRecipientType.ClientID %>");
            cmbMTMRecipient.enable();
            var cmbMTMDisposition = $find("<%=cmbCMDisposition.ClientID %>");
            cmbMTMDisposition.enable();


            var cmbPrescribers = $find("<%=cmbPrescribers.ClientID %>");
            cmbPrescribers.enable();

            var cmrPrescribers = $find("<%=cmrPrescribers.ClientID %>");
            cmrPrescribers.enable();

            var cmbProviders = $find("<%=cmbProviders.ClientID %>");
            cmbProviders.enable();

            var cmbPharmacist = $find("<%=cmbPharmacist.ClientID %>");
            cmbPharmacist.enable();

            $("[id*=txtOtherPrescriberProvider1]").attr('disabled', false);
            $("[id*=txtOtherPrescriberProvider2]").attr('disabled', false);
            $("[id*=txtOtherPrescriberProvider3]").attr('disabled', false);
            $("[id*=txtSubOtherNPI1]").attr('disabled', false);
            $("[id*=txtSubOtherNPI2]").attr('disabled', false);
            $("[id*=txtSubOtherNPI3]").attr('disabled', false);


            $("[id*=chkCMHIPAAVerified]").removeAttr('disabled');
            $("[id*=cmkCMRScheduled]").removeAttr('disabled');
            var cmbLTCIndicator = $find("<%=cmbLTCIndicator.ClientID %>");
            cmbLTCIndicator.enable();



            return false;
        }

        function ClearMTMControlsOnConfirmWithoutPatientImpairedInfo() {

            EnableMTMControls();

            $('#divMtmTriage').find('input, textarea, button, select').attr('disabled', false);
            $("[id*=txtMTMTriageComments]").val('');
            $("[id*=chkCMRFollowUp]").attr('disabled', true);
            $("[id*=chkFollowUpAttemptCompleted]").attr('disabled', true);


            var datepicker1 = $find("<%=RDPCMRScheduledDate.ClientID %>");

            datepicker1.set_enabled(true);
            datepicker1.clear();


            var cmbCMRRecipient = $find("<%= cmbCMRRecipient.ClientID %>");
            var itm_cmbCMRRecipient = cmbCMRRecipient.findItemByText('Select');
            itm_cmbCMRRecipient.select();


            //0503
            var datepicker2 = $find("<%=rdDateOfDeath.ClientID %>");
            datepicker2.clear();

            $("[id*=chkCMRFollowUp]").removeAttr('checked');
            $("[id*=chkCMRFollowUp]").removeAttr('disabled');
            $("[id*=chkFollowUpAttemptCompleted]").removeAttr('checked');
            $("[id*=chkFollowUpAttemptCompleted]").removeAttr('disabled');




            //            $("[id*=txtContactPrefix]").val('');
            //            $("[id*=txtContactFirstName]").val('');
            //            $("[id*=txtContactLastName]").val('');

            /***CR 420
            var cmbCMROptOut = $find("<%= cmbCMROptOut.ClientID %>");
            var itm_cmbCMROptOut = cmbCMROptOut.findItemByValue('0');
            itm_cmbCMROptOut.select();
            cmbCMROptOut.enable();
            **/

            var datepickerRadDateCMROptOutDate = $find("<%=RadDateCMROptOutDate.ClientID %>");
            datepickerRadDateCMROptOutDate.clear();
            datepickerRadDateCMROptOutDate.set_enabled(false);

            var rdReason = $find("<%= rdReason.ClientID %>");
            rdReason.disable();

            var RadComboOptOutSource = $find("<%= RadComboOptOutSource.ClientID %>");
            RadComboOptOutSource.disable();

            $("[id*=rdDuration]").attr('disabled', true);
            $("[id*=TxtCMRComments]").val('');
            $("[id*=TxtCMRComments]").attr('disabled', true);

            var cmbMTMOptOut = $find("<%=cmbMTMOptOut.ClientID %>");
            var itm_cmbMTMOptOut = cmbMTMOptOut.findItemByValue('0');
            itm_cmbMTMOptOut.select();

            var cmbCMROptOut = $find("<%=cmbCMROptOut.ClientID %>");
            cmbCMROptOut.enable();
            var itm_cmbCMROptOut = cmbCMROptOut.findItemByValue('0');
            itm_cmbCMROptOut.select();
            cmbCMROptOut.disable();

            //cmbMTMOptOut.enable();

            var datepicker = $find("<%=RadDateMTMOptOutDate_MTM.ClientID %>");
            datepicker.clear();
            datepicker.set_enabled(false);

            var rdOptOutReason_MTM = $find("<%=rdOptOutReason_MTM.ClientID %>");
            var itm_rdOptOutReason_MTM = rdOptOutReason_MTM.findItemByValue('0');
            itm_rdOptOutReason_MTM.select();
            rdOptOutReason_MTM.disable();

            var rdReason_MTM = $find("<%= rdReason_MTM.ClientID %>");
            var itm_rdReason_MTM = rdReason_MTM.findItemByValue('0');
            itm_rdReason_MTM.select();
            rdReason_MTM.disable();

            $("[id*=TxtMTMComments]").val('');
            $("[id*=TxtMTMComments]").attr('disabled', true);
            $("[id*=rdDuration_MTM]").attr('disabled', true);

            /**CR 420 Controls Hide**/


            var cmbMTMCallType = $find("<%=cmbMTMCallType.ClientID %>");
            var itm_cmbMTMCallType = cmbMTMCallType.findItemByValue('0');
            itm_cmbMTMCallType.select();

            var cmbRecipientType = $find("<%=cmbRecipientType.ClientID %>");
            var itm_cmbRecipientType = cmbRecipientType.findItemByText('Select');
            itm_cmbRecipientType.select();

            var cmbCMDisposition = $find("<%=cmbCMDisposition.ClientID %>");
            var itm_cmbCMDisposition = cmbCMDisposition.findItemByText('Select');
            itm_cmbCMDisposition.select();

            cmbRecipientType.disable();
            cmbCMDisposition.disable();

            var cmbPharmacist = $find("<%=cmbPharmacist.ClientID %>");
            var itm_cmbPharmacist = cmbPharmacist.findItemByText('Select');
            if (itm_cmbPharmacist != null)
                itm_cmbPharmacist.select();

            var cmbProviders = $find("<%=cmbProviders.ClientID %>");
            var itm_cmbProviders = cmbProviders.findItemByText('Select');
            if (itm_cmbProviders != null)
                itm_cmbProviders.select();

            var cmbPrescribers = $find("<%=cmbPrescribers.ClientID %>");
            var itm_cmbPrescribers = cmbPrescribers.findItemByText('Select');
            if (itm_cmbPrescribers != null)
                itm_cmbPrescribers.select();

            var cmbCMRRecipient = $find("<%=cmbCMRRecipient.ClientID %>");
            var itm_cmbCMRRecipient = cmbCMRRecipient.findItemByText('Select');
            if (itm_cmbCMRRecipient != null)
                itm_cmbCMRRecipient.select();

            var cmrPrescribers = $find("<%=cmrPrescribers.ClientID %>");
            var itm_cmrPrescribers = cmrPrescribers.findItemByText('Select');
            if (itm_cmrPrescribers != null)
                itm_cmrPrescribers.select();

            var cmrProviders = $find("<%=cmrProviders.ClientID %>");
            var itm_cmrProviders = cmrProviders.findItemByText('Select');
            if (itm_cmrProviders != null)
                itm_cmrProviders.select();




            var cmbRelationToBeneficiary_MTM = $find("<%=cmbRelationToBeneficiary_MTM.ClientID %>");
            cmbRelationToBeneficiary_MTM.enable();
            var itm_cmbRelationToBeneficiary_MTM = cmbRelationToBeneficiary_MTM.findItemByValue('0');
            if (itm_cmbRelationToBeneficiary_MTM != null)
                itm_cmbRelationToBeneficiary_MTM.select();

            cmbRelationToBeneficiary_MTM.disable();


            //txtOther
            //Other 


            $("[id*=cmkCMRScheduled]").attr('disabled', false);
            $("[id*=cmkCMRScheduled]").removeAttr('checked');

            $("[id*=chkCMRFollowUp]").attr('disabled', false);
            $("[id*=chkCMRFollowUp]").removeAttr('checked');

            $("[id*=trCheckboxes]").css('display', 'none');

            $("[id*=chkFollowUpAttemptCompleted]").attr('disabled', false);
            $("[id*=chkFollowUpAttemptCompleted]").removeAttr('checked');

            $("[id*=chkCMHIPAAVerified]").removeAttr('checked');

            $("[id*=trCMRScheduledDate]").css('display', 'none');

            $("[id*=trRecipientType]").css('display', '');
            $("[id*=trLTC]").css('display', '');
            $("[id*=trHipaa]").css('display', '');



            ResetAllControlsAndHide();
            /**
            $("[id*=MainContent_ucCMRTMR_trRelationToBeneficiary]").css('display', 'none');
            $("[id*=MainContent_ucCMRTMR_trAppointedRep]").css('display', 'none');
            $("[id*=trRecipientOfCMRContactName]").css('display', 'none');
            $("[id*=MainContent_ucCMRTMR_trContactName]").css('display', 'none');
            $("[id*=trRecipientOfCMRAppointedRep]").css('display', 'none');
            $("[id*=MainContent_ucCMRTMR_trRecipientOfCMR]").css('display', 'none');
            $("[id*=trCMRPrescribers]").css('display', 'none');
            $("[id*=trProviders]").css('display', 'none');
            $("[id*=trPrescribersList]").css('display', 'none');
            hideCMRScheduledSecion(true);
            hideFollowupScheduledSecion(true);
            $("[id*=trPharmacists]").css('display', 'none');
            **/
            /**CR 420 Controls**/

            //$("#MainContent_ucCMRTMR_divCMROptout").css('display', 'none');
            //$("#MainContent_ucCMRTMR_divCMROptout").css('visibility', 'hidden');
            //$("#MainContent_ucCMRTMR_divMTMOptOut").css('visibility', 'hidden');
            // $("#MainContent_ucCMRTMR_divMTMOptOut").css('display', 'none');

            /**Other Name/ prescriber/Providers clearing**/
            $("[id*=txtOtherPrescriberProvider1]").val('');
            $("[id*=txtOtherPrescriberProvider2]").val('');
            $("[id*=txtOtherPrescriberProvider3]").val('');
            $("[id*=txtSubOtherNPI1]").val('');
            $("[id*=txtSubOtherNPI2]").val('');
            $("[id*=txtSubOtherNPI3]").val('');
            //            $("[id*=txtContactPrefix]").val('');
            //            $("[id*=txtContactFirstName]").val('');
            //            $("[id*=txtContactLastName]").val('');
            $("[id*=txtCMRContactPrefix]").val('');
            $("[id*=txtCMRContactFirstName]").val('');
            $("[id*=txtCMRContactLastName]").val('');





            $find("<%= TxtRelationToBenfeficiaryOther.ClientID %>").clear();
            $find("<%= TxtCMROtherSource.ClientID %>").clear();
            $find("<%= TxtOptOutReasonOther.ClientID %>").clear();
            $find("<%= TxtMTMOtherExplanation.ClientID %>").clear();
            /**CMR Opt Out controls clearing*/
            var RadComboOptOutSource = $find("<%= RadComboOptOutSource.ClientID %>");
            var rdReasonCombo = $find("<%=rdReason.ClientID %>");
            RadComboOptOutSource.enable();
            rdReasonCombo.enable();
            var itm_RadComboOptOutSource = RadComboOptOutSource.findItemByText('Select');
            if (itm_RadComboOptOutSource != undefined && itm_RadComboOptOutSource != 'undefined')
                itm_RadComboOptOutSource.select();
            RadComboOptOutSource.disable();

            var itm_rdReasonCombo = rdReasonCombo.findItemByText('Select');
            if (itm_rdReasonCombo != undefined && itm_rdReasonCombo != 'undefined')
                itm_rdReasonCombo.select();
            rdReasonCombo.disable();

            $find("<%= TxtCMROtherExplanation.ClientID %>").clear();


            $("[id*=TxtRelationToBenfeficiaryOther]").attr('disabled', true);
            $("[id*=TxtOptOutReasonOther]").attr('disabled', true);

            //$("[id*=btnCancelMTMTriage]").css('display', '');
            CloseConfirmPopUp();

            return false;
        }
        function clearMTMOptOutControls() {
            var cmbMTMOptOut = $find("<%=cmbMTMOptOut.ClientID %>");
            var itm_cmbMTMOptOut = cmbMTMOptOut.findItemByValue('0');
            itm_cmbMTMOptOut.select();

            var datepicker = $find("<%=RadDateMTMOptOutDate_MTM.ClientID %>");
            datepicker.clear();
            datepicker.set_enabled(false);

            var datepickerDateOfDeath = $find("<%=rdDateOfDeath.ClientID %>");
            datepickerDateOfDeath.clear();
            datepickerDateOfDeath.set_enabled(false);

            var rdOptOutReason_MTM = $find("<%=rdOptOutReason_MTM.ClientID %>");
            var itm_rdOptOutReason_MTM = rdOptOutReason_MTM.findItemByValue('0');
            itm_rdOptOutReason_MTM.select();
            rdOptOutReason_MTM.disable();

            var rdReason_MTM = $find("<%= rdReason_MTM.ClientID %>");
            var itm_rdReason_MTM = rdReason_MTM.findItemByValue('0');
            itm_rdReason_MTM.select();
            rdReason_MTM.disable();

            $("[id*=TxtMTMComments]").val('');
            $("[id*=TxtMTMComments]").attr('disabled', true);
            $("[id*=rdDuration_MTM]").attr('disabled', true);
            $find("<%= TxtCMROtherSource.ClientID %>").clear();
            $find("<%= TxtOptOutReasonOther.ClientID %>").clear();
            $find("<%= TxtMTMOtherExplanation.ClientID %>").clear();



        }

        function clearCMROptOutControls() {

            var cmbCMROptOut = $find("<%=cmbCMROptOut.ClientID %>");
            cmbCMROptOut.enable();
            var itm_cmbCMROptOut = cmbCMROptOut.findItemByValue('0');
            itm_cmbCMROptOut.select();
            cmbCMROptOut.disable();

            var datepicker = $find("<%=RadDateCMROptOutDate.ClientID %>");
            datepicker.clear();
            datepicker.set_enabled(false);

            var RadComboOptOutSource = $find("<%= RadComboOptOutSource.ClientID %>");
            var rdReasonCombo = $find("<%=rdReason.ClientID %>");
            RadComboOptOutSource.enable();
            rdReasonCombo.enable();
            var itm_RadComboOptOutSource = RadComboOptOutSource.findItemByText('Select');
            if (itm_RadComboOptOutSource != undefined && itm_RadComboOptOutSource != 'undefined')
                itm_RadComboOptOutSource.select();
            RadComboOptOutSource.disable();

            var itm_rdReasonCombo = rdReasonCombo.findItemByText('Select');
            if (itm_rdReasonCombo != undefined && itm_rdReasonCombo != 'undefined')
                itm_rdReasonCombo.select();
            rdReasonCombo.disable();

            $find("<%= TxtCMROtherExplanation.ClientID %>").clear();

        }
        function ClearMTMControlsOnConfirm() {

            EnableMTMControls();
            $('#divMtmTriage').find('input, textarea, button, select').attr('disabled', false);
            $("[id*=txtMTMTriageComments]").val('');
            $("[id*=chkCMRFollowUp]").attr('disabled', true);
            $("[id*=chkFollowUpAttemptCompleted]").attr('disabled', true);

            // $('[id*=lblPatientRepName]').text('No Appointed Rep');

            //$("#<%=lnkChangeRecpientName.ClientID %>").text('Add');


            //$('[id*=lnkChangeRecpientName]')[0].innerText = 'Add';

            var datepicker1 = $find("<%=RDPCMRScheduledDate.ClientID %>");
            datepicker1.set_enabled(true);
            datepicker1.clear();


            //0503
            var datepicker2 = $find("<%=rdDateOfDeath.ClientID %>");
            datepicker2.clear();

            $("[id*=chkCMRFollowUp]").removeAttr('checked');
            $("[id*=chkCMRFollowUp]").removeAttr('disabled');
            $("[id*=chkFollowUpAttemptCompleted]").removeAttr('checked');
            $("[id*=chkFollowUpAttemptCompleted]").removeAttr('disabled');




            $("[id*=txtContactPrefix]").val('');
            $("[id*=txtContactFirstName]").val('');
            $("[id*=txtContactLastName]").val('');

            var cmbCMROptOut = $find("<%= cmbCMROptOut.ClientID %>");
            var itm_cmbCMROptOut = cmbCMROptOut.findItemByValue('0');
            itm_cmbCMROptOut.select();

            var datepickerRadDateCMROptOutDate = $find("<%=RadDateCMROptOutDate.ClientID %>");
            datepickerRadDateCMROptOutDate.clear();
            datepickerRadDateCMROptOutDate.set_enabled(false);

            var rdReason = $find("<%= rdReason.ClientID %>");
            rdReason.disable();

            var RadComboOptOutSource = $find("<%= RadComboOptOutSource.ClientID %>");
            RadComboOptOutSource.disable();

            $("[id*=rdDuration]").attr('disabled', true);
            $("[id*=TxtCMRComments]").val('');
            $("[id*=TxtCMRComments]").attr('disabled', true);

            var cmbMTMOptOut = $find("<%=cmbMTMOptOut.ClientID %>");
            var itm_cmbMTMOptOut = cmbMTMOptOut.findItemByValue('0');
            itm_cmbMTMOptOut.select();
            var datepicker = $find("<%=RadDateMTMOptOutDate_MTM.ClientID %>");
            datepicker.clear();
            datepicker.set_enabled(false);

            var rdOptOutReason_MTM = $find("<%=rdOptOutReason_MTM.ClientID %>");
            var itm_rdOptOutReason_MTM = rdOptOutReason_MTM.findItemByValue('0');
            itm_rdOptOutReason_MTM.select();
            rdOptOutReason_MTM.disable();

            var rdReason_MTM = $find("<%= rdReason_MTM.ClientID %>");
            var itm_rdReason_MTM = rdReason_MTM.findItemByValue('0');
            itm_rdReason_MTM.select();
            rdReason_MTM.disable();

            $("[id*=TxtMTMComments]").val('');
            $("[id*=TxtMTMComments]").attr('disabled', true);
            $("[id*=rdDuration_MTM]").attr('disabled', true);

            // $find("<%=TxtOptOutReasonOther.ClientID %>").clear();


            //  $find("<%= TxtRelationToBenfeficiaryOther.ClientID %>").clear();

            //            
            //            cmbPatientImpaired = $find("<%= cmbPatientImpaired.ClientID %>");
            //            itm_cmbPatientImpaired = cmbPatientImpaired.findItemByValue('3');
            //            itm_cmbPatientImpaired.select();

            $find("<%= TxtCMROtherExplanation.ClientID %>").clear();
            $find("<%= TxtRelationToBenfeficiaryOther.ClientID %>").clear();
            $find("<%= TxtCMROtherSource.ClientID %>").clear();
            $find("<%= TxtOptOutReasonOther.ClientID %>").clear();
            $find("<%= TxtMTMOtherExplanation.ClientID %>").clear();

            $("[id*=TxtRelationToBenfeficiaryOther]").attr('disabled', true);
            $("[id*=TxtOptOutReasonOther]").attr('disabled', true);

            //$("[id*=btnCancelMTMTriage]").css('display', '');
            CloseConfirmPopUp();

            return false;
        }

        function CloseConfirmPopUp() {
            var rdWindow = $find('<%=rdConfirmWindowForClear.ClientID %>');
            rdWindow.close();
            return false;
        }
        function CloserdConfirmSave() {
            var rdWindow = $find('<%=rdConfirmSave.ClientID %>');
            rdWindow.close();
            return false;
        }
        //        var mtmFieldsModified = false;
        //        $('.NoPrint').on('change', 'input, select, textarea', function () {
        //            mtmFieldsModified = true;
        //        });
        function btnContinue_Click() {
            DisableMTMControls();
            var oWnd = $find("<%= rwPreCMR.ClientID %>");
            oWnd.Close();
        }
        
    </script>
</telerik:RadScriptBlock>
<telerik:RadCodeBlock ID="cmrtmrRadCodeBlock" runat="server">
    <script type="text/javascript">

        function RefreshAppRepresentData(name) {
            // $('[id*=lblPatientRepName]').text(name);
            // $('[id*=lnkChangeRecpientName]').text('Change');
            $('[id*=hdnRepName]').val(name);
            RefreshAppRepData();

        }
        function RefreshAppRepData() {

            if (document.getElementById('<%=btnRefreshData.ClientID%>') != null)
                document.getElementById('<%=btnRefreshData.ClientID%>').click();
        }
        function OptOut() {
            var oWnd = $find("<%= rwPreCMR.ClientID %>");
            oWnd.Close();
            if (typeof RefreshClose == 'function') { RefreshClose(); }
        }
        function OptInDoc() {
            MTMTriage_Modified = 0;
            var oWnd = $find("<%= rwPreCMR.ClientID %>");
            oWnd.Close();
            if (typeof RefreshDocs == 'function') { RefreshDocs(); }
        }
        function PrescriberEditPopUpTriage(event, nonAdId, NPI, type) {

            event.stopPropagation();
            var DialogId;
            var wnd;
            var SessionIsClosedAlert = listView_SessionIsClosedAlert;
            var tempdate = new Date();
            '<%Page.Encrypt("edit", true);%>'
            var EncEdit = '<%=Page.EncryptedValue%>';
            if (type == 1) {
                type = "Prescriber";
                '<%Page.Encrypt("Prescriber", true);%>'
                type = '<%=Page.EncryptedValue%>';
                DialogId = "radPrescriber";
            } else {
                type = "Provider";
                '<%Page.Encrypt("Provider", true);%>'
                type = '<%=Page.EncryptedValue%>';
                DialogId = "radProvider";
            }

            var tempdate = new Date();
            //var encryptEdit = '<%Page.Encrypt("edit", true);%>';
            // encryptEdit = '<%=Page.EncryptedValue%>';
            var qsRef = 'NPISearchMultiSelect.aspx<%=QueryStringTokenWithMandatoryQuestionMarkAndOptionalAmpersand%>mode=' + EncEdit + '&nonAdId=' + (nonAdId) + '&NPI=' + NPI + '&type=' + type + '';
            //var qsRef = 'NPISearchMultiSelect.aspx<%=QueryStringTokenWithMandatoryQuestionMarkAndOptionalAmpersand%>mode=' + encryptEdit + '&nonAdId=' + encodeURIComponent(nonAdId) + '&NPI=' + NPI + '&type=' + type + '';
            var manager = $find('rwmWindowManager');
            manager.open(qsRef, DialogId);
            return false;

        }
        function PrescriberAddPopUpTriage(event, nonAdId, NPI, type) {

            event.stopPropagation();
            var DialogId;
            var wnd;
            var SessionIsClosedAlert = listView_SessionIsClosedAlert;
            var encryptAdd = '<%Page.Encrypt("add", true);%>';
            encryptAdd = '<%=Page.EncryptedValue%>';
            if (type == 1) {
                type = "Prescriber";
                '<%Page.Encrypt("Prescriber", true);%>'
                type = '<%=Page.EncryptedValue%>';
                DialogId = "radPrescriber";
            } else {
                type = "Provider";
                '<%Page.Encrypt("Provider", true);%>'
                type = '<%=Page.EncryptedValue%>';
                DialogId = "radProvider";
            }

            var tempdate = new Date();
            var tempdate = new Date();
            var qsRef = 'NPISearchMultiSelect.aspx<%=QueryStringTokenWithMandatoryQuestionMarkAndOptionalAmpersand%>mode=' + encryptAdd + '&nonAdId=' + (nonAdId) + '&NPI=' + NPI + '&type=' + type + '';
            //  var qsRef = 'NPISearchMultiSelect.aspx<%=QueryStringTokenWithMandatoryQuestionMarkAndOptionalAmpersand%>mode=' + encryptAdd + '&nonAdId=' + encodeURIComponent(nonAdId) + '&NPI=' + NPI + '&type=' + type + '';
            var manager = $find('rwmWindowManager');
            manager.open(qsRef, DialogId);
            return false;
        }
        function CancelPopUpCMRTMR() {
            //            var oWnd = $find("<%= radMsgWindowToNext.ClientID %>");
            //            oWnd.Close();
            //document.location.reload(true)
            //window.parent.location = window.parent.location.href;
            //return false;
            document.getElementById('<%=btnRefreshTriage.ClientID%>').click();
        }

        function RedirectToNextCase() {
            var url = window.location.href;
            var n = url.lastIndexOf("/");
            url = url.substring(0, n + 1) + "HomePage.aspx<%=QueryStringTokenWithQuestionMark%>";
            window.parent.location = url;
        }

        function RedirectToQueue() {
            var url = window.location.href.substring(0, window.location.href.lastIndexOf("/"));
            var n = url.lastIndexOf("/");
            url = url.substring(0, n + 1) + "QueueManager/QueueManager.aspx<%=QueryStringTokenWithQuestionMark%>";
            window.parent.location = url;
        }
        function CloseMsgWindowQ() {
            //            var oWnd = $find("<%= RadWindowQ.ClientID %>");
            //            oWnd.Close();
            var url = window.location.href.substring(0, window.location.href.lastIndexOf("/"));
            var n = url.lastIndexOf("/");
            url = url.substring(0, n + 1) + "QueueManager/QueueManager.aspx<%=QueryStringTokenWithQuestionMark%>";
            window.parent.location = url;

        }

        function OnRadComboOptOutSourceSelectedIndexChanged(sender, args) {
            var item = args.get_item();
            var itemText = args.get_item()._text;
            if (itemText == "Other") {
                $("[id*=TxtCMROtherSource]").attr('disabled', false);
            }
            else {
                $find("<%= TxtCMROtherSource.ClientID %>").clear();
                $("[id*=TxtCMROtherSource]").attr('disabled', true);
            }
        }

        function OnRdReasonSelectedIndexChanged(sender, args) {

            var item = args.get_item();
            if (args.get_item().get_text() != "Select")
                sender.get_element().title = args.get_item().get_text();
            else
                sender.get_element().title = "";
            var itemText = args.get_item()._text;
            if (itemText == "Other") {

                $("[id*=TxtCMROtherExplanation]").attr('disabled', false);
            }
            else {
                $find("<%= TxtCMROtherExplanation.ClientID %>").clear();
                $("[id*=TxtCMROtherExplanation]").attr('disabled', false);
                $("[id*=TxtCMROtherExplanation]").attr('disabled', true);
            }
            sender.get_element().onfocus = args.get_item().get_text();
        }
        function OnRdReason_MTMSelectedIndexChanged(sender, args) {
            if (args.get_item().get_text() != "Select")
                sender.get_element().title = args.get_item().get_text();
            else
                sender.get_element().title = "";

            var item = args.get_item();
            var itemText = args.get_item()._text;
            if (itemText == "Other") {

                $("[id*=TxtMTMOtherExplanation]").attr('disabled', false);
            }
            else {
                $find("<%= TxtMTMOtherExplanation.ClientID %>").clear();
                $("[id*=TxtMTMOtherExplanation]").attr('disabled', true);
            }
            sender.get_element().onfocus = args.get_item().get_text();
        }


        var reviewDirtyPopUpToShow = '';
        var reviewDrugIdPopUp = '';

        function FireEditCommand() {
            if (reviewDirtyPopUpToShow == 'CMR') {
                var masterTable = $find("<%= CMRGrid.ClientID %>").get_masterTableView();
                masterTable.fireCommand("EditLink", reviewDrugIdPopUp);
            } else if (reviewDirtyPopUpToShow == 'TMR') {

                var masterTable = $find("<%= TMRGrid.ClientID %>").get_masterTableView();
                masterTable.fireCommand("EditLink", reviewDrugIdPopUp);
            }

        }

        function FireTMREditCommand(DrugreviewSummaryId) {
            var masterTable = $find("<%= TMRGrid.ClientID %>").get_masterTableView();
            masterTable.fireCommand("EditLink", reviewDrugIdPopUp);

        }
        function EditCMR(index) {
            var masterTable = $find("<%= CMRGrid.ClientID %>").get_masterTableView();
            if (MTMTriage_Modified == 1) {
                // var oWnd = $find("ctl00_MainContent_radConfirmWindow");
                var oWnd = $find("<%= radConfirmWindowCMRTMR.ClientID %>");
                oWnd.show();
                oWnd.minimize();
                oWnd.maximize();
                oWnd.restore();
                // form_has_been_modified = 0;
                return false;
                args.set_cancel(true);

            } else {
                reviewDrugIdPopUp = index;
                reviewDirtyPopUpToShow = 'CMR';
                masterTable.fireCommand("EditLink", index);
            }
        }

        function EditTMR(index) {
            var masterTable = $find("<%= TMRGrid.ClientID %>").get_masterTableView();
            if (MTMTriage_Modified == 1) {
                var oWnd = $find("ctl00_MainContent_radConfirmWindow");
                oWnd.show();
                oWnd.minimize();
                oWnd.maximize();
                oWnd.restore();
                // form_has_been_modified = 0;
                return false;
                args.set_cancel(true);

            } else {
                reviewDrugIdPopUp = index;
                reviewDirtyPopUpToShow = 'TMR';
                masterTable.fireCommand("EditLink", index);
            }
        }
        function lnlEditCMR_ClientClick(sender, args) {
            //            alert('called');
            //            if (args.get_commandName() == "EditLink") {
            //                if (MTMTriage_Modified == 1) {
            //                    //radconfirm("Changes have been made on this page. If you wish to leave this page without saving your changes, click 'Yes', otherwise click 'No'", callBackFunc, 450, 150, "", "WARNING");
            //                    var oWnd = $find("ctl00_MainContent_radConfirmWindow");
            //                    oWnd.show();
            //                    oWnd.minimize();
            //                    oWnd.maximize();
            //                    oWnd.restore();
            //                    // form_has_been_modified = 0;
            //                    return false;
            //                    args.set_cancel(true);
            //                } else {

            //                    MTMTriage_Modified = 0;
            //                    form_has_been_modified = 0;
            //                    args.set_cancel(false);

            //                }
            //            
            //            }


        }



        Telerik.Web.UI.RadWindowUtils.Localization =
        {
            "Close": "Close",
            "Minimize": "Minimize",
            "Maximize": "Maximize",
            "Reload": "Reload",
            "PinOn": "Pin on",
            "PinOff": "Pin off",
            "Restore": "Restore",
            "OK": "OK",
            "Cancel": "Cancel",
            "Yes": "Yes",
            "No": "No"
        };
        function onAjaxRequestStart(sender, args) {
            if (args.get_eventTargetElement().innerText == "Delete CMR" || args.get_eventTargetElement().innerText == "Delete TMR")
                args.set_enableAjax(true);

            //            args.set_enableAjax(false);
            //            var masterTable=$find("<%= CMRGrid.ClientID %>").get_masterTableView();
            //            var lndelete = masterTable.get_dataItems()[0];

            //           //.findControl('lnlDeleteTMR');


        }

        
    </script>
</telerik:RadCodeBlock>
<%--<telerik:RadAjaxPanel ID="RadAjaxpanel1" runat="server" EnableAJAX="true" LoadingPanelID="RadAjaxLoadingPanel1">--%>
<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="btnRefreshData">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl UpdatePanelRenderMode="Inline" ControlID="lblPatientRepName" />
                <telerik:AjaxUpdatedControl ControlID="lnkChangeRecpientName" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<table width="100%">
    <tr>
        <td>
        </td>
    </tr>
</table>
<div class="NoPrint" style="height: 100%; border-top-style: none; border-right-style: none;
    border-left-style: none; border-bottom-style: none; position: relative; top: -10;">
    <telerik:RadTimeView ID="SharedTimeView" runat="server">
    </telerik:RadTimeView>
    <telerik:RadCalendar ID="SharedCalendar" runat="server" EnableMonthYearFastNavigation="False"
        EnableMultiSelect="False" UseColumnHeadersAsSelectors="False" UseRowHeadersAsSelectors="False">
    </telerik:RadCalendar>
    <table width="100%" style="font-family: Mangal !important;">
        <tr class="blueBarHeader">
            <td style="width: 50%;">
                <span class="rpText">MTM Triage</span>
            </td>
            <td align="right" style="width: 50%; padding-right: 5px;">
            </td>
        </tr>
        <tr>
            <td style="width: 100%;" colspan="2">
                <%-- <div id='divMtmTriage' style="float: left; width: 100%;">--%>
                <table style="width: 100%">
                    <tr>
                        <td id="tdYellowBar" colspan="2">
                            <table width="100%">
                                <tr class="yellowBarHeader" style="width: 100%; height: 10px;">
                                    <td style="width: 60%;">
                                        &nbsp;
                                        <asp:Label ID="lblLastTriage" Text="N/A" runat="server" />
                                    </td>
                                    <td align="right" style="width: 40%; text-align: right !important; padding-right: 2px !important;">
                                        <asp:LinkButton ID="lnkViewTriageLog" Enabled="true" runat="server" OnClientClick="ViewMTMTriage();return false;"
                                            ForeColor="Black" Text="View Triage Log"></asp:LinkButton>
                                        &nbsp;
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <asp:Button ID="btnRefreshTriage" runat="server" Text="Finalize" ForeColor="White"
                            Style="display: none" OnClick="btnRefreshTriage_Click" />
                        <td id="triageLeft" style="border-right-color: rgb(229, 229, 229); border-right-width: 1px;
                            border-right-style: solid;">
                            <%--height:400px;--%>
                            <table style="float: left; width: 99%">
                                <tr style="height: 30px">
                                    <td align="right" style="width: 30%">
                                        <span class="headerFont">Call type:</span>
                                    </td>
                                    <td align='left' style="width: 70%">
                                        <telerik:RadComboBox runat="server" ID="cmbMTMCallType" Width="250px" OnClientSelectedIndexChanged="OnClientCallTypeSelectedIndexChanged">
                                        </telerik:RadComboBox>
                                        <span style='position: absolute;' class="failureNotification">*</span>
                                        <%--<span class="failureNotification">*</span>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="cmbPersonContacted"
                                            ErrorMessage="Required" CssClass="failureNotification" InitialValue="Select"
                                            ValidationGroup="preCMR"></asp:RequiredFieldValidator>--%>
                                    </td>
                                </tr>
                                <tr id="trRecipientType" runat="server" style="height: 30px">
                                    <td align="right" style="width: 38%">
                                        <span class="headerFont">Recipient type:</span>
                                    </td>
                                    <td align='left' style="width: 62%">
                                        <%--OnClientSelectedIndexChanged="OnRecipientTypeClientSelectedIndexChanged" OnSelectedIndexChanged="cmbCMRecipientType_SelectedIndexChanged"--%>
                                        <telerik:RadComboBox runat="server" ID="cmbRecipientType" Width="250px" AutoPostBack="false"
                                            OnClientSelectedIndexChanged="OnRecipientTypeClientSelectedIndexChanged">
                                        </telerik:RadComboBox>
                                        <span style='position: absolute;' class="failureNotification">*</span>
                                        <%--<span class="failureNotification">*</span>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="cmbPersonContacted"
                                            ErrorMessage="Required" CssClass="failureNotification" InitialValue="Select"
                                            ValidationGroup="preCMR"></asp:RequiredFieldValidator>--%>
                                    </td>
                                </tr>
                                <tr id="trContactName" runat="server" style="height: 30px">
                                    <td align="right" style="width: 30%">
                                        <span class="headerFont">Name:</span>
                                    </td>
                                    <td align='left' style="width: 70%">
                                        <asp:TextBox Width="50px" ID="txtContactPrefix" placeholder="Prefix" runat="server"
                                            MaxLength="4" />
                                        <asp:TextBox Width="90px" ID="txtContactFirstName" placeholder="First Name" runat="server"
                                            MaxLength="25" />
                                        <asp:TextBox Width="90px" ID="txtContactLastName" placeholder="Last Name" runat="server"
                                            MaxLength="25" />
                                    </td>
                                </tr>
                                <tr id="trPrescribersList" runat="server" style="display: none; height: 30px">
                                    <td align="right" style="width: 30%">
                                        <span class="headerFont">Prescribers:</span>
                                    </td>
                                    <td align='left' style="width: 70%">
                                        <telerik:RadComboBox runat="server" ID="cmbPrescribers" Width="250px" MaxHeight="150px"
                                            OnClientSelectedIndexChanged="OnPrescriberClientSelectedIndexChanged">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr id="trProviders" runat="server" style="display: none; height: 30px">
                                    <td align="right" style="width: 30%">
                                        <span class="headerFont">Pharmacies:</span>
                                    </td>
                                    <td align='left' style="width: 70%">
                                        <telerik:RadComboBox runat="server" ID="cmbProviders" Width="250px" OnClientSelectedIndexChanged="OnProviderClientSelectedIndexChanged">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr id="trOtherPrescriberProvider" runat="server" style="display: none; height: 30px">
                                    <td align="right" style="width: 30%">
                                        <span class="headerFont">Other:</span>
                                    </td>
                                    <td align='left' style="width: 70%">
                                        <asp:TextBox Width="50px" ID="txtOtherPrescriberProvider1" placeholder="Prefix" runat="server"
                                            MaxLength="4" />
                                        <asp:TextBox Width="90px" ID="txtOtherPrescriberProvider2" placeholder="First Name"
                                            runat="server" MaxLength="25" />
                                        <asp:TextBox Width="90px" ID="txtOtherPrescriberProvider3" placeholder="Last Name"
                                            runat="server" MaxLength="25" />
                                    </td>
                                </tr>
                                <tr id="trRelationToBeneficiary" runat="server" style="height: 30px">
                                    <td align="right">
                                        <span class="headerFont">Relation to Beneficiary:</span>
                                    </td>
                                    <td align='left'>
                                        <telerik:RadComboBox runat="server" ID="cmbRelationToBeneficiary_MTM" Width="250px"
                                            AutoPostBack="false" OnClientSelectedIndexChanged="cmbRelationToBeneficiary_MTM_IndexChanged">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr id="trOtherRelationToBeneficiary" style="display: none; height: 30px" runat="server">
                                    <td align="right">
                                        <span class="headerFont">Other Relation to Beneficiary:</span>
                                    </td>
                                    <td align='left'>
                                        <telerik:RadTextBox DisabledStyle-CssClass="disabled-control" ID="TxtRelationToBenfeficiaryOther"
                                            runat="server" Width="180px" MaxLength="50">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr id="trAppointedRep" style="height: 30px" runat="server">
                                    <td id="tdCMRRecipientName" runat="server" style="width: 30%" align="right">
                                        <span class="headerFont">Representative:</span>
                                    </td>
                                    <td id="tdCMRRecipientNameValues" runat="server" align='left' style="float: left">
                                        <div style="float: left">
                                            <asp:Label runat="server" ID="lblPatientRepName" CssClass="frmlabelnew">No Appointed Rep</asp:Label>
                                            &nbsp;
                                        </div>
                                        <div style="float: left; margin-left: 2px;">
                                            <asp:LinkButton runat="server" ID="lnkChangeRecpientName" Text="Change"></asp:LinkButton>
                                        </div>
                                    </td>
                                </tr>
                                <tr id="trDisposition" runat="server" style="height: 30px">
                                    <td align="right">
                                        <span class="headerFont">Disposition:</span>
                                    </td>
                                    <td align='left'>
                                        <telerik:RadComboBox runat="server" ID="cmbCMDisposition" Width="250px" OnClientSelectedIndexChanged="cmbCMDispositionChanged">
                                        </telerik:RadComboBox>
                                        <span id="spanDisposition" runat="server" class="failureNotification">*</span>
                                    </td>
                                </tr>
                                <tr id="trPharmacists" runat="server" style="display: none; height: 30px">
                                    <td align="right">
                                        <span class="headerFont">Pharmacist:</span>
                                    </td>
                                    <td align='left'>
                                        <telerik:RadComboBox runat="server" ID="cmbPharmacist" AutoPostBack="false" Width="250px"
                                            MaxHeight="150px">
                                        </telerik:RadComboBox>
                                        <%--<span id="spanProvider" runat="server" class="failureNotification">&nbsp;*&nbsp;&nbsp;</span>--%>
                                    </td>
                                </tr>
                                <tr style="height: 30px" id="trCheckboxes" runat="server">
                                    <td align="right" colspan="2">
                                        <%--Added for CR-1047.--%>
                                        <table width="100%" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td style="width: 20%" align="left">
                                                    <div id="divCMRScheduledCheckbox" runat="server" style="float: left; margin-left: 10px">
                                                        <input type="checkbox" id="cmkCMRScheduled" style="vertical-align: middle; margin-top: -1px"
                                                            onclick="checkCMRScheduled(this);" runat="server" /><span id="spnCMRScheduled" class="headerFont">CMR
                                                                Scheduled</span>
                                                    </div>
                                                </td>
                                                <td style="width: 30%">
                                                    <div id="divFollowupRequiredCheckbox" runat="server" style="float: left; margin-left: 30px">
                                                        <input type="checkbox" id="chkCMRFollowUp" style="vertical-align: middle; margin-top: -1px"
                                                            onclick="checkFollowUp(this);" runat="server" /><span id="spnFollowupRequired" class="headerFont">Follow-Up
                                                                Required</span>
                                                    </div>
                                                </td>
                                                <td style="width: 40%">
                                                    <div id="divFollowupCompletedRequiredCheckbox" runat="server" style="float: left;
                                                        margin-left: 30px">
                                                        <input type="checkbox" id="chkFollowUpAttemptCompleted" style="vertical-align: middle;
                                                            margin-top: -1px" onclick="checkFollowUpAttempts(this);" runat="server" /><span id="spnFollowupCompleted"
                                                                class="headerFont">Follow-Up Attempts Completed</span><asp:Label class="headerFont"
                                                                    runat="server" ID="lblFollowUpCounter"></asp:Label>
                                                        <asp:HiddenField ID="hdnFollowUpCounter" runat="server" Value="0" />
                                                        <asp:HiddenField ID="hdnIsFollowUpAttemptChecked" runat="server" Value="0" />
                                                        <asp:HiddenField ID="hdnInProgressPrivlgCmr" runat="server" Value="0" />
                                                        <asp:HiddenField ID="hdnInProgressPrivlgTmr" runat="server" Value="0" />
                                                        <%--Added for Ticket#16533--%>
                                                        <asp:HiddenField ID="hdnCheckFollowUpAttempts" runat="server" Value="0" />
                                                         <%--Added for Ticket#16624--%>
                                                        <asp:HiddenField ID="hdnFollowUpHidden" runat="server" Value="0" />
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr id="trCMRScheduledDate" runat="server" style="height: 35px">
                                    <td align="right" style="width: 30%">
                                        <span id="spanScheduledDate" runat="server" class="headerFont">CMR Scheduled Date:</span>
                                    </td>
                                    <td align='left' style="width: 70%">
                                        <div style="float: left">
                                            <div style="float: left">
                                                <%--Added DateInput-ReadOnly for CR-1047 -- Offline--%>
                                                <telerik:RadDateTimePicker ID="RDPCMRScheduledDate" DateInput-ReadOnly="true" runat="server"
                                                    Width="180px">
                                                </telerik:RadDateTimePicker>
                                            </div>
                                            <div style="float: left; line-height: 19px;">
                                                <asp:Label ID="lnkTimeZone" Text="EST" runat="server" ForeColor="Black" Font-Bold="true"></asp:Label>
                                            </div>
                                        </div>
                                        <div style="float: left; margin-top: 2px">
                                            <telerik:RadToolTip Visible="false" ID="RadToolTipCase" runat="server" TargetControlID="lnkTimeZone"
                                                Width="250px" RelativeTo="Element" Position="BottomRight" RenderInPageRoot="true"
                                                EnableShadow="true" ShowEvent="OnClick" AutoCloseDelay="20000" ManualClose="true">
                                                <table width="100%" class="divSections" border="0" cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td class="subheaderFont">
                                                        </td>
                                                        <td class="subheaderFont">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                        </td>
                                                        <td class="subheaderFont">
                                                            <asp:RadioButtonList ID="chkDrugFormatList" runat="server" RepeatColumns="3" RepeatDirection="Horizontal"
                                                                Width="100%" onclick="javascript:return CheckedChangeTriage(this)">
                                                                <asp:ListItem Text="EST" Value="EST" Selected="True" onclick="javascript:return CheckedChangeTriage(this)"></asp:ListItem>
                                                                <asp:ListItem Text="CST" Value="CST" onclick="javascript:return CheckedChangeTriage(this)"></asp:ListItem>
                                                                <asp:ListItem Text="AST" Value="AST" onclick="javascript:return CheckedChangeTriage(this)"></asp:ListItem>
                                                                <asp:ListItem Text="MST" Value="MST" onclick="javascript:return CheckedChangeTriage(this)"></asp:ListItem>
                                                                <asp:ListItem Text="PST" Value="PST" onclick="javascript:return CheckedChangeTriage(this)"></asp:ListItem>
                                                                <asp:ListItem Text="HST" Value="HST" onclick="javascript:return CheckedChangeTriage(this)"></asp:ListItem>
                                                                <asp:ListItem Text="AKST" Value="AKST" onclick="javascript:return CheckedChangeTriage(this)"></asp:ListItem>
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </telerik:RadToolTip>
                                            <div style='float: left; padding-left: 10px;'>
                                                <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server">
                                                </telerik:RadAjaxLoadingPanel>
                                                <telerik:RadAjaxPanel ID="rapCMRScheduledDate" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                                                    <asp:HiddenField ID="hdnSelectedCMRScheduleDate" Value="" runat="server" />
                                                    <asp:LinkButton ID="lnkScheduleAppointment" runat="server" ForeColor="Blue" Font-Bold="true"
                                                        Visible="true" Text="Schedule Appointment" OnClick="lnkScheduleAppointment_Click"
                                                        OnClientClick="if(ScheduleCMRAppointment('') == false){return false;}scroll(0,0);"></asp:LinkButton>
                                                </telerik:RadAjaxPanel>
                                            </div>
                                        </div>
                                        <div style="float: left; margin-left: 5px;">
                                        </div>
                                    </td>
                                </tr>
                                <tr id="trRecipientOfCMR" runat="server" style="display: none; height: 30px">
                                    <td align="right" style="width: 30%">
                                        <span id="spnRecipientOfCMR" runat="server" class="headerFont">Recipient of CMR:</span>
                                    </td>
                                    <td align='left' style="width: 70%">
                                        <telerik:RadComboBox runat="server" ID="cmbCMRRecipient" Width="250px" MaxHeight="150px"
                                            OnClientSelectedIndexChanged="CMRRecipientChanged">
                                        </telerik:RadComboBox>
                                        <asp:HiddenField ID="hdnRepName" runat="server" />
                                    </td>
                                </tr>
                                <tr id="trRecipientOfCMRContactName" style="height: 30px" runat="server">
                                    <td align="right" style="width: 30%">
                                        <span class="headerFont">Name:</span>
                                    </td>
                                    <td align='left' style="width: 70%">
                                        <asp:TextBox Width="50px" ID="txtCMRContactPrefix" placeholder="Prefix" runat="server"
                                            MaxLength="4" />
                                        <asp:TextBox Width="90px" ID="txtCMRContactFirstName" placeholder="First Name" runat="server"
                                            MaxLength="25" />
                                        <asp:TextBox Width="90px" ID="txtCMRContactLastName" placeholder="Last Name" runat="server"
                                            MaxLength="25" />
                                    </td>
                                </tr>
                                <tr id="trRecipientOfCMRAppointedRep" runat="server" style="height: 30px">
                                    <td id="tdRecipientName" runat="server" style="width: 30%" align="right">
                                        <span class="headerFont">Representative:</span>
                                    </td>
                                    <td id="td1" runat="server" align='left' style="float: left">
                                        <div style="float: left">
                                            <asp:Label runat="server" ID="lblCMRPatientRepName" CssClass="frmlabelnew">No Appointed Rep</asp:Label>
                                            &nbsp;
                                        </div>
                                        <div style="float: left; margin-left: 2px;">
                                            <asp:LinkButton runat="server" ID="lnkCMRChangeRecpientName" Text="Change"></asp:LinkButton>
                                        </div>
                                    </td>
                                </tr>
                                <tr id="trCMRPrescribers" runat="server" style="display: none; height: 30px">
                                    <td align="right" style="width: 30%">
                                        <span class="headerFont">Prescribers:</span>
                                    </td>
                                    <td align='left' style="width: 70%">
                                        <telerik:RadComboBox runat="server" ID="cmrPrescribers" Width="150px" OnClientSelectedIndexChanged="OncmrProvidersClientSelectedIndexChanged">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr id="trCMRProviders" runat="server" style="display: none; height: 30px">
                                    <td align="right" style="width: 30%">
                                        <span class="headerFont">Pharmacies:</span>
                                    </td>
                                    <td align='left' style="width: 70%">
                                        <telerik:RadComboBox runat="server" ID="cmrProviders" Width="150px" OnClientSelectedIndexChanged="OncmrProvidersClientSelectedIndexChanged">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr id="trCMRPrescriberProviderOther" runat="server" style="display: none; height: 30px">
                                    <td align="right" style="width: 30%">
                                        <span class="headerFont">Other:</span>
                                    </td>
                                    <td align='left' style="width: 70%">
                                        <asp:TextBox Width="50px" ID="txtSubOtherNPI1" placeholder="Prefix" runat="server"
                                            MaxLength="4" />
                                        <asp:TextBox Width="90px" ID="txtSubOtherNPI2" placeholder="First Name" runat="server"
                                            MaxLength="25" />
                                        <asp:TextBox Width="90px" ID="txtSubOtherNPI3" placeholder="Last Name" runat="server"
                                            MaxLength="25" />
                                    </td>
                                </tr>
                                <tr id="trHipaa" runat="server" style="height: 30px">
                                    <td>
                                    </td>
                                    <td colspan="2" align="left">
                                        <div>
                                            <asp:CheckBox runat="server" ID="chkCMHIPAAVerified" Style="vertical-align: middle;
                                                margin-top: -1px" />
                                            <span class="headerFont">HIPAA Verified</span>
                                        </div>
                                    </td>
                                </tr>
                                <tr style="height: 77px">
                                    <td align="right">
                                        <span class="headerFont">Comments (Max 2000 Chars):</span>
                                    </td>
                                    <td align='left'>
                                        <asp:TextBox ID="txtMTMTriageComments" runat="server" TextMode="MultiLine" Width="90%"
                                            onKeyDown="limitText(this,2000);" onKeyUp="limitText(this,2000);" onmouseover="limitText(this,2000);"
                                            Height="60px" CssClass="textEntry" />
                                    </td>
                                </tr>
                                <tr style="height: auto">
                                </tr>
                            </table>
                        </td>
                        <td id="triageRight" style="width: 53%">
                            <table style="width: 100%; float: left">
                                <tr>
                                    <td style="width: 60%">
                                        <table>
                                            <tr id="trLTC" runat="server">
                                                <td align="right" style="width: 46%">
                                                    <span class="headerFont">LTC Indicator:</span>
                                                </td>
                                                <td align='left' style="width: 54%">
                                                    <telerik:RadComboBox runat="server" ID="cmbLTCIndicator" Width="80px" AutoPostBack="false">
                                                        <Items>
                                                            <telerik:RadComboBoxItem Text="Yes" Value="1" />
                                                            <telerik:RadComboBoxItem Text="No" Value="2" />
                                                            <telerik:RadComboBoxItem Text="Unknown" Value="3" />
                                                        </Items>
                                                    </telerik:RadComboBox>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 44%">
                                                    <span class="headerFont">Patient Cognitively Impaired:</span>
                                                </td>
                                                <td align='left' style="width: 56%">
                                                    <telerik:RadComboBox runat="server" ID="cmbPatientImpaired" Width="80px" OnClientSelectedIndexChanged="radCmbPatientImpaired_ClientSelectedIndexChanged"
                                                        AutoPostBack="false">
                                                    </telerik:RadComboBox>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 44%">
                                                    <span class="headerFont">Effective Date:</span>
                                                </td>
                                                <td align='left' style="width: 56%">
                                                    <div style="float: left">
                                                        <telerik:RadDatePicker ID="RadDateCIEffectiveDate" DateInput-ReadOnly="true" runat="server"
                                                            Width="180px" MaxDate="<%# DateTime.Today.Date %>" Enabled="false">
                                                            <ClientEvents OnDateSelected="RadDateCIEffectiveDate_OnDateSelected"></ClientEvents>
                                                        </telerik:RadDatePicker>
                                                    </div>
                                                    <div style="float: left; margin-top: 2px">
                                                        <div style="float: left;">
                                                            <asp:Label ID="Label4" runat="server" Text="EST" ForeColor="Black" Font-Bold="true"></asp:Label>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 44%">
                                                    <span class="headerFont">Source:</span>
                                                </td>
                                                <td align='left' style="width: 56%">
                                                    <div style="float: left">
                                                        <asp:Label ID="lblCISourceValue" runat="server" Text="" ForeColor="Black" Font-Bold="true"></asp:Label>
                                                        <asp:HiddenField ID="hdnSourceValue" runat="server" Value="" />
                                                        <asp:HiddenField ID="hdnSessionUserName" runat="server" Value="" />
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style="width: 40%">
                                        <table>
                                            <tr>
                                                <td colspan="2">
                                                    <div style='float: left; margin-right: 5px;'>
                                                        <u id='lnkViewEditBIMS' onclick="ListView_ShowBIMSAssessments(event, this, 'Test')"
                                                            style='color: Blue;' class="headerFont">View/Edit BIMS Assessment</u>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right; width: 70%" class="headerFont">
                                                    Last BIMS Score:
                                                </td>
                                                <td style="text-align: left; width: 30%">
                                                    <asp:Label ID="lblBIMSScore" runat="server" Text="N/A"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right" class="headerFont">
                                                    Last BIMS Date:
                                                </td>
                                                <td style="text-align: left">
                                                    <asp:Label ID="lblBIMSDate" runat="server" Text="N/A"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr id="trOptOut">
                                    <td colspan='2'>
                                        <div id="divCMROptout" runat="server" style="height: 250px">
                                            <fieldset style="padding: 10px 0px 0px 0px; width: auto;">
                                                <legend>CMR Opt Out:</legend>
                                                <table width="100%">
                                                    <tr>
                                                        <td align="right" style="width: 25%">
                                                            <span class="headerFont">Opt Out:</span>
                                                        </td>
                                                        <td align="left" style="width: 25%">
                                                            <telerik:RadComboBox runat="server" ID="cmbCMROptOut" AutoPostBack="false" Width="80px"
                                                                OnClientSelectedIndexChanged="OnCMROptOutClientSelectedIndexChanged">
                                                                <Items>
                                                                    <telerik:RadComboBoxItem Text="No" Value="0" />
                                                                    <telerik:RadComboBoxItem Text="Yes" Value="1" />
                                                                    <%-- <telerik:RadComboBoxItem Text="Select" Value="2" />--%>
                                                                </Items>
                                                            </telerik:RadComboBox>
                                                        </td>
                                                        <td align="right" style="width: 25%">
                                                            <span class="headerFont">Opt Out Date:</span>
                                                        </td>
                                                        <td align="left" style="width: 25%">
                                                            <div style="float: left">
                                                                <%--Added DateInput-ReadOnly for CR-1047 -- Offline--%>
                                                                <telerik:RadDatePicker ID="RadDateCMROptOutDate" DateInput-ReadOnly="true" runat="server"
                                                                    Width="120px" SharedCalendarID="SharedCalendar" SharedTimeViewID="SharedTimeView">
                                                                </telerik:RadDatePicker>
                                                            </div>
                                                            <div style="float: left; margin-top: 2px">
                                                                <div style="float: left;">
                                                                    <%--<asp:LinkButton ID="lnkpreCMRFollowUpTimeZone" runat="server" ForeColor="Black" Font-Bold="true"
                                        Text="EST" OnClientClick="lnkNextFollowupDateClickTriageFollowUp(this);return false;"></asp:LinkButton>--%>
                                                                    <asp:Label ID="Label1" runat="server" Text="EST" ForeColor="Black" Font-Bold="true"></asp:Label>
                                                                </div>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="right" style="width: 35%">
                                                            <span class="headerFont">Opt Out Information Source:</span>
                                                        </td>
                                                        <td align="left" style="width: 15%">
                                                            <telerik:RadComboBox ID="RadComboOptOutSource" ExpandDirection="Down" Height="100px"
                                                                runat="server" ViewStateMode="Enabled" AutoPostBack="false" OnClientSelectedIndexChanged="OnRadComboOptOutSourceSelectedIndexChanged"
                                                                Width="150px">
                                                            </telerik:RadComboBox>
                                                        </td>
                                                        <td align="right" style="width: 25%">
                                                            <span class="headerFont">Opt Out Other Source:</span>
                                                        </td>
                                                        <td align="right" style="width: 25%">
                                                            <telerik:RadTextBox DisabledStyle-CssClass="disabled-control" ID="TxtCMROtherSource"
                                                                runat="server" Width="150px" MaxLength="50">
                                                            </telerik:RadTextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="right" style="width: 30%">
                                                            <span class="headerFont">Opt Out Explanation:</span>
                                                        </td>
                                                        <td align="left" style="width: 25%">
                                                            <telerik:RadComboBox ID="rdReason" runat="server" Enabled="false" ViewStateMode="Enabled"
                                                                OnClientSelectedIndexChanged="OnRdReasonSelectedIndexChanged" Width="150px">
                                                            </telerik:RadComboBox>
                                                            <%--<telerik:RadToolTip ID="rdCMRReasonTooltip" runat="server" Width="100" Height="10" Position="TopRight"  
            Text="" TargetControlID="rdReason">
        </telerik:RadToolTip>  --%>
                                                        </td>
                                                        <td align="right" style="width: 35%">
                                                            <span class="headerFont">Opt Out Other Explanation:</span>
                                                        </td>
                                                        <td align="left" style="width: 20%">
                                                            <telerik:RadTextBox DisabledStyle-CssClass="disabled-control" ID="TxtCMROtherExplanation"
                                                                runat="server" Width="150px" MaxLength="50">
                                                            </telerik:RadTextBox>
                                                        </td>
                                                    </tr>
                                                    <tr style='display: none;'>
                                                        <td align="right" style="width: 30%">
                                                            <span class="headerFont">Opt Out Duration:</span>
                                                        </td>
                                                        <td>
                                                            <asp:RadioButtonList ID="rdDuration" CssClass="frmradiobutton" runat="server" Enabled="false"
                                                                RepeatDirection="Horizontal">
                                                                <asp:ListItem Selected="True" Value="0">Current Year</asp:ListItem>
                                                                <asp:ListItem Value="1">Permanently</asp:ListItem>
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <tr id="tr1">
                                                        <td align="right">
                                                            <span class="headerFont">Opt Out Comments (Max 2000 Chars):</span>
                                                        </td>
                                                        <td colspan="3">
                                                            <asp:TextBox ID="TxtCMRComments" runat="server" Enabled="false" TextMode="MultiLine"
                                                                onKeyDown="limitText(this,2000);" onKeyUp="limitText(this,2000);" onmouseover="limitText(this,2000);"
                                                                Width="98%" MaxLength="2000" Height="60px" CssClass="textEntry" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                    </tr>
                                                </table>
                                            </fieldset>
                                        </div>
                                        <div id="divMTMOptOut" runat="server" style="height: 250px">
                                            <fieldset style="padding: 10px 0px 0px 0px; width: auto;">
                                                <legend>MTM Program Opt Out:</legend>
                                                <table width="100%">
                                                    <tr>
                                                        <td align="right" style="width: 17%">
                                                            <span class="headerFont">Opt Out:</span>
                                                        </td>
                                                        <td style="width: 25%">
                                                            <telerik:RadComboBox runat="server" ID="cmbMTMOptOut" AutoPostBack="false" Width="80px"
                                                                OnClientSelectedIndexChanged="OnMTMOptOutClientSelectedIndexChanged">
                                                                <Items>
                                                                    <telerik:RadComboBoxItem Text="No" Value="0" />
                                                                    <telerik:RadComboBoxItem Text="Yes" Value="1" />
                                                                    <%--<telerik:RadComboBoxItem Text="Select" Value="2" />--%>
                                                                </Items>
                                                            </telerik:RadComboBox>
                                                        </td>
                                                        <td align="right" style="width: 30%">
                                                            <span class="headerFont">Opt Out Date:</span>
                                                        </td>
                                                        <td align='left' style="width: 25%">
                                                            <div style="float: left">
                                                                <%--Added DateInput-ReadOnly for CR-1047 -- Offline--%>
                                                                <telerik:RadDatePicker ID="RadDateMTMOptOutDate_MTM" DateInput-ReadOnly="true" runat="server"
                                                                    Enabled="false" Width="120px" SharedCalendarID="SharedCalendar" SharedTimeViewID="SharedTimeView">
                                                                </telerik:RadDatePicker>
                                                            </div>
                                                            <div style="float: left; margin-top: 2px">
                                                                <div style="float: left;">
                                                                    <asp:Label ID="Label2" runat="server" Text="EST" ForeColor="Black" Font-Bold="true"></asp:Label>
                                                                </div>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="right" style="width: 17%">
                                                            <span class="headerFont">Opt Out Duration:</span>
                                                        </td>
                                                        <td align="left" style="width: 30%">
                                                            <asp:RadioButtonList ID="rdDuration_MTM" CssClass="frmradiobutton" runat="server"
                                                                Enabled="false" RepeatDirection="Horizontal">
                                                                <asp:ListItem Value="1">Current Year</asp:ListItem>
                                                                <asp:ListItem Value="2">Permanently</asp:ListItem>
                                                            </asp:RadioButtonList>
                                                            <asp:HiddenField ID="hdnCheck_MTM" runat="server" Value="0" />
                                                        </td>
                                                        <td align="right" style="width: 30%">
                                                            <span class="headerFont">Date of Death:</span>
                                                        </td>
                                                        <td>
                                                            <div style="float: left">
                                                                <%-- <telerik:RadDatePicker ID="rdDateOfDeath" runat="server" Width="120px" SharedCalendarID="SharedCalendar"
                                                                    SharedTimeViewID="SharedTimeView" DateInput-DateFormat="MM/dd/yyyy" MinDate="01/01/1800">
                                                                </telerik:RadDatePicker>--%>
                                                                <%--Added DateInput-ReadOnly for CR-1047 -- Offline--%>
                                                                <telerik:RadDatePicker ID="rdDateOfDeath" DateInput-ReadOnly="true" runat="server"
                                                                    Culture="en-US" Width="120px" ShowPopupOnFocus="False">
                                                                </telerik:RadDatePicker>
                                                            </div>
                                                            <div style="float: left; margin-top: 2px">
                                                                <div style="float: left;">
                                                                    <asp:Label ID="Label3" runat="server" Text="EST" ForeColor="Black" Font-Bold="true"></asp:Label>
                                                                </div>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr id="tr4" class="DisabledTriage">
                                                        <td align="right" class="DisabledTriage" style="width: 25%">
                                                            <span class="headerFont">Opt Out Reason:</span>
                                                        </td>
                                                        <td style="width: 25%" class="DisabledTriage">
                                                            <telerik:RadComboBox ID="rdOptOutReason_MTM" ExpandDirection="Down" runat="server"
                                                                Height="150px" Enabled="false" ViewStateMode="Enabled" Width="150px" OnClientSelectedIndexChanged="rdOptOutReason_MTM_IndexChanged">
                                                            </telerik:RadComboBox>
                                                            <%-- <telerik:RadToolTip ID="rdTooltipMTMOptOutReason" runat="server" Width="100" Height="10" Position="TopRight" 
            Text="" TargetControlID="rdOptOutReason_MTM" >  </telerik:RadToolTip> --%>
                                                        </td>
                                                        <td align="right" style="width: 25%">
                                                            <span class="headerFont">Opt Out Other Reason:</span>
                                                        </td>
                                                        <td>
                                                            <telerik:RadTextBox DisabledStyle-CssClass="disabled-control" ID="TxtOptOutReasonOther"
                                                                runat="server" Width="150px" MaxLength="50">
                                                            </telerik:RadTextBox>
                                                        </td>
                                                    </tr>
                                                    <tr id="tr2" class="DisabledTriage">
                                                        <td align="right" style="width: 25%">
                                                            <span class="headerFont">Opt Out Explanation:</span>
                                                        </td>
                                                        <td style="width: 25%">
                                                            <telerik:RadComboBox ID="rdReason_MTM" runat="server" Enabled="false" ViewStateMode="Enabled"
                                                                OnClientSelectedIndexChanged="OnRdReason_MTMSelectedIndexChanged" Width="150px">
                                                            </telerik:RadComboBox>
                                                            <%-- <telerik:RadToolTip ID="rdReason_MTMTooltip" runat="server" Width="100" Height="10" Position="TopRight" 
            Text="" TargetControlID="rdReason_MTM" >  </telerik:RadToolTip> --%>
                                                        </td>
                                                        <td align="right" style="width: 25%">
                                                            <span class="headerFont">Opt Out Other Explanation:</span>
                                                        </td>
                                                        <td>
                                                            <telerik:RadTextBox DisabledStyle-CssClass="disabled-control" ID="TxtMTMOtherExplanation"
                                                                runat="server" Width="150px" MaxLength="50">
                                                            </telerik:RadTextBox>
                                                        </td>
                                                    </tr>
                                                    <tr id="tr3" class="DisabledTriage">
                                                        <td align="right">
                                                            <span class="headerFont">Opt Out Comments (Max 2000 Chars):</span>
                                                        </td>
                                                        <td colspan="3">
                                                            <asp:TextBox ID="TxtMTMComments" runat="server" TextMode="MultiLine" Width="98%"
                                                                onKeyDown="limitText(this,2000);" onKeyUp="limitText(this,2000);" onmouseover="limitText(this,2000);"
                                                                MaxLength="2000" Height="60px" CssClass="textEntry" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                    </tr>
                                                </table>
                                            </fieldset>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <table style="float: right; margin: 10px 0">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lbVendor" Visible="false" Style="color: Red; font-size: 11px" runat="server"
                                                        Text="The case will be unassigned from and assigned back to Prime"></asp:Label>
                                                </td>
                                                <td>
                                                    <telerik:RadButton ID="btnCancelMTMTriage" runat="server" Text="Cancel" CssClass="AgadiaButton1"
                                                        OnClientClicked="btnCancelMTMTriage_ClientClick" OnClick="btnCancelMTMTriage_Click">
                                                    </telerik:RadButton>
                                                </td>
                                                <td>
                                                    <telerik:RadButton ID="btnClearMTMTriage" runat="server" Text="Add New" CssClass="AgadiaButton1"
                                                        OnClientClicked="ClearMTMControls_ClientClick" AutoPostBack="false">
                                                    </telerik:RadButton>
                                                </td>
                                                <td>
                                                    <telerik:RadButton ID="btnSaveMTMTriage" runat="server" Text="Save" CssClass="AgadiaButton1"
                                                        OnClientClicked="clientSaveMTMTriage" ConfirmDialogType="RadWindow" ConfirmDialogWidth="400px"
                                                        ConfirmDialogHeight="120px" ValidationGroup="preCMR" OnClick="btnSaveMTMTriage_Click">
                                                    </telerik:RadButton>
                                                </td>
                                                <td>
                                                    <telerik:RadButton ID="btnEditMTMTriage" runat="server" Text="Edit" Visible="false"
                                                        CssClass="AgadiaButton1" OnClientClicked="EnableMTMControls_ClientClick" AutoPostBack="false">
                                                    </telerik:RadButton>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <telerik:RadWindow ID="rdConfirmWindowForClear" runat="server" Modal="true" VisibleOnPageLoad="false"
                    Height="140px" Width="350px" BackColor="#DADADA" VisibleStatusbar="false" Behaviors="None"
                    Title="MTM" OnClientBeforeShow="ShowWindowCenterToTheScreen">
                    <ContentTemplate>
                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td colspan="2" style="padding-top: 20px; height: 2px" align="center">
                                    <span id="spanVendor" class="label" style="color: #767676" runat="server">Do you want
                                        to cancel all your changes?</span>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-top: 10px" align="right">
                                    <input runat="server" id="btnAssignCaseVendor" type="button" width="80px" class="AgadiaButton"
                                        onclick='CancelMTMChangesOnConfirm();return false;' value="Yes" />
                                </td>
                                <td style="padding-top: 10px" align="left">
                                    <input runat="server" id="btnClosePopup" type="button" width="80px" class="AgadiaButton"
                                        value="No" onclick='CloseConfirmPopUp();' />
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </telerik:RadWindow>
                <telerik:RadWindow ID="rdConfirmSave" runat="server" Modal="true" VisibleOnPageLoad="false"
                    Height="140px" Width="350px" BackColor="#DADADA" VisibleStatusbar="false" Behaviors="None"
                    Title="MTM" OnClientBeforeShow="ShowWindowCenterToTheScreen">
                    <ContentTemplate>
                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td colspan="2" style="padding-top: 20px; height: 2px" align="center">
                                    <span id="spnConfirmSave" class="label" style="color: #767676" runat="server">You selected
                                        to opt out from CMR. Do you want to continue?</span>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-top: 10px" align="right">
                                    <input runat="server" id="Button1" type="button" width="80px" class="AgadiaButton"
                                        onclick='ContinueCMRMTMSave();' value="Yes" />
                                </td>
                                <td style="padding-top: 10px" align="left">
                                    <input runat="server" id="Button3" type="button" width="80px" class="AgadiaButton"
                                        value="Cancel" onclick='CloserdConfirmSave();' />
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </telerik:RadWindow>
                <telerik:RadWindow ID="radConfirmWindowCMRTMR" runat="server" Modal="true" VisibleOnPageLoad="false"
                    Height="170px" Width="450px" BackColor="#DADADA" VisibleStatusbar="false" Behaviors="None"
                    Title="Message">
                    <ContentTemplate>
                        <div style="padding: 2px">
                            <table style="width: 100%; height: 100px;" border='0'>
                                <tr>
                                    <td id="Td2" style='text-align: left !important; vertical-align: middle !important;'
                                        runat="server">
                                        Do you want to save changes?
                                        <br />
                                        <ul>
                                            <li>* Click 'Yes' to save changes.</li>
                                            <li>* Click 'No' to discard changes.</li>
                                            <li>* Click 'Cancel' to cancel current action.</li>
                                        </ul>
                                    </td>
                                </tr>
                                <tr style='height: 30px; text-align: center;'>
                                    <td>
                                    </td>
                                    <td align="center" valign="bottom">
                                        <asp:Button CssClass="AgadiaButton" ID="Button28" runat="server" Text="Yes" Width="50px"
                                            OnClientClick="javascript:SaveChangesAndContinue();return false;" />
                                    </td>
                                    <td align="center" valign="bottom">
                                        <asp:Button CssClass="AgadiaButton" ID="Button29" runat="server" Text="No" Width="50px"
                                            OnClientClick="javascript:FireEditCommand();return false;" />
                                    </td>
                                    <td align="center" valign="bottom">
                                        <asp:Button CssClass="AgadiaButton" ID="Button30" runat="server" Text="Cancel" Width="50px"
                                            OnClientClick="javascript:StayOnPage();return false;" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </ContentTemplate>
                </telerik:RadWindow>
                <telerik:RadWindowManager ID="RadWindowManagerMTMTriage" OnClientBeforeShow="fixIE10"
                    runat="server" Style="z-index: 7001" ClientIDMode="Static" Height="700px" Width="1200px"
                    Modal="true">
                    <Windows>
                        <telerik:RadWindow ID="MTMTriageDialog" runat="server" ReloadOnShow="False" VisibleStatusbar="false"
                            Title="MTM Triage Log" Width="1200px" Left="20px" Modal="True" Height="550px"
                            Behaviors="Maximize,Close">
                        </telerik:RadWindow>
                        <telerik:RadWindow ID="CMRAppointmentScheduler" runat="server" ReloadOnShow="False"
                            VisibleStatusbar="false" Title="MTM Triage Log" Width="1100px" Left="20px" Modal="True"
                            Height="600px" Behaviors="Close" OnClientClose="clientCloseCMRAppointment">
                        </telerik:RadWindow>
                    </Windows>
                </telerik:RadWindowManager>
                <telerik:RadWindow ID="radMsgWindowToNext" runat="server" Modal="true" VisibleOnPageLoad="false"
                    Height="180px" Width="350px" BackColor="#DADADA" VisibleStatusbar="false" Behaviors="Close"
                    OnClientClose="CancelPopUpCMRTMR" Title="MTM Triage">
                    <ContentTemplate>
                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td style="padding-top: 20px; height: 2px" align="center">
                                    <span id="spnMsg" class="label" style="color: #767676" runat="server">All changes are
                                        final
                                        <br />
                                        <br />
                                        How would you like to proceed? </span>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-top: 10px" align="center">
                                    <asp:Button CssClass="AgadiaButton" ID="Button12" runat="server" Text="Get Next Case"
                                        Width="80px" OnClick="btnGetNext_Click" />
                                    &nbsp;
                                    <asp:Button CssClass="AgadiaButton" ID="Button2" runat="server" Text="Queue Manager"
                                        Width="100px" OnClientClick="RedirectToQueue();return false; " />&nbsp;
                                    <asp:Button CssClass="AgadiaButton" ID="ButtonPopup" runat="server" Text="Continue this Case"
                                        Width="100px" OnClientClick="CancelPopUpCMRTMR();return false;" />
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </telerik:RadWindow>
                <telerik:RadWindow ID="RadWindowForValidation" runat="server" Modal="true" VisibleOnPageLoad="false"
                    Height="190px" Width="370px" BackColor="#DADADA" VisibleStatusbar="false" Behaviors="None"
                    Title="MTM Validations">
                    <ContentTemplate>
                        <div style="padding: 20px; text-align: left!important;">
                            <span id="Span1" style="padding-left: 7px!important;" class="label" runat="server">Please
                                select one of the following options:</span>
                            <br />
                            <ul class="ulList">
                                <li>Follow-Up Required, Follow-Up Date and Follow-Up with</li>
                                <li>Follow-Up Attempts Completed</li>
                                <li>CMR Scheduled, CMR Scheduled Date and Recipient of CMR</li>
                            </ul>
                            <asp:Button Style="margin-left: 130px!important;" CssClass="AgadiaButton" ID="Button8"
                                runat="server" Text="OK" Width="50px" OnClientClick="javascript:CloseRadWindowForValidation();return false; " />
                        </div>
                    </ContentTemplate>
                </telerik:RadWindow>
                <telerik:RadWindow ID="RadWindowForValidation1" runat="server" Modal="true" VisibleOnPageLoad="false"
                    Height="160px" Width="350px" BackColor="#DADADA" VisibleStatusbar="false" Behaviors="None"
                    Title="MTM Validations">
                    <ContentTemplate>
                        <div style="padding: 20px; text-align: left!important;">
                            <span id="Span2" style="padding-left: 7px!important;" class="label" runat="server">Please
                                select one of the following options:</span>
                            <br />
                            <ul class="ulList">
                                <li>Follow-Up Required, Follow-Up Date and Follow-Up with</li>
                                <li>Follow-Up Attempts Completed</li>
                            </ul>
                            <asp:Button Style="margin-left: 130px!important;" CssClass="AgadiaButton" ID="Button4"
                                runat="server" Text="OK" Width="50px" OnClientClick="javascript:CloseRadWindowForValidation1();return false; " />
                        </div>
                    </ContentTemplate>
                </telerik:RadWindow>
                <telerik:RadWindow ID="RadWindowQ" runat="server" Modal="true" VisibleOnPageLoad="false"
                    Height="130px" Width="300px" BackColor="#DADADA" VisibleStatusbar="false" Behaviors="None"
                    Title="Queue Manager">
                    <ContentTemplate>
                        <div style="padding: 20px; text-align: center">
                            <span id="SpanQ" class="label" runat="server">Rule Description:</span>
                            <br />
                            <br />
                            <asp:Button CssClass="AgadiaButton" ID="Button6" runat="server" Text="OK" Width="50px"
                                OnClientClick="javascript:CloseMsgWindowQ();return false; " />
                        </div>
                    </ContentTemplate>
                </telerik:RadWindow>
                <telerik:RadWindow ID="radMsgWindow2" runat="server" Modal="true" VisibleOnPageLoad="false"
                    Height="150px" Width="550px" BackColor="#DADADA" VisibleStatusbar="false" Behaviors="Close"
                    Title="" OnClientBeforeShow="fixIE10">
                    <ContentTemplate>
                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td style="padding-top: 20px; height: 2px" align="center">
                                    <div id="spnMsg2" class="label" style="color: #767676; display: block;" runat="server">
                                        Name:</div>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-top: 10px" align="center">
                                    <asp:Button CssClass="AgadiaButton" ID="ButtonReleaseLock" runat="server" Text="Release Lock"
                                        OnClick="btnReleaseAllLocksByUser_Click" Width="80px" />
                                    <asp:Button CssClass="AgadiaButton" ID="Button5" OnClientClick="javascript:CloseMsgWindow2();return false;"
                                        runat="server" Text="Cancel" Width="80px" />
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </telerik:RadWindow>
                <telerik:RadWindow ID="raddeleteForCMRTMR" runat="server" Modal="true" VisibleOnPageLoad="false"
                    Height="230px" Width="419px" BackColor="#DADADA" VisibleStatusbar="false" Behaviors="close,move"
                    Title="Reason for Deleting" OnClientBeforeShow="ShowWindowCenterToTheScreen">
                    <ContentTemplate>
                        <%--<telerik:RadAjaxPanel ID="rap" runat="server" ClientEvents-OnRequestStart="OnRequestStartDelete"
            ClientEvents-OnResponseEnd="OnResponseEndDelete" LoadingPanelID='ralp'>--%>
                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td style="padding-top: 10px; height: 2px" align="center">
                                    <span id="spanTxtForModule" runat="server" class="label" style="color: black; margin-left: 5px!important"
                                        runat="server"></span>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="vertical-align: top; text-align: center;">
                                    <%--<telerik:RadTextBox ID="txtMultiNoteAcknowledge" runat="server"  ValidationGroup="ValidationGroupForAcknowledge"
                            TextMode="MultiLine" Width="330px" Rows="6" MaxLength="2000">
                        </telerik:RadTextBox>--%>
                                    <asp:TextBox ID="txtReasonForDeleteCMRTMR" CssClass="textEntryDblLength" runat="server"
                                        onKeyDown="limitText(this,250);" onKeyUp="limitText(this,250);" onmouseover="limitText(this,250);"
                                        ValidationGroup="ValidationGroupForTMRCMRDelete" TextMode="MultiLine" Width="320px"
                                        Rows="5" MaxLength="250"></asp:TextBox>
                                    <span class="failureNotification" style="vertical-align: top">*</span>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" style="padding-top: 10px; width: 200px">
                                    <asp:Button ID="btnDeleteCMRTMR" runat="server" Text="OK" CssClass="AgadiaButton"
                                        OnClientClick="javascript:OnSaveClickForDelete();return false;" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="spnForDelete" Style="display: none;" runat="server" CssClass="failureNotification"
                                        Text=""></asp:Label>
                                </td>
                            </tr>
                        </table>
                        <%--</telerik:RadAjaxPanel>
        <telerik:RadAjaxLoadingPanel ID="ralp" runat="server" />--%>
                    </ContentTemplate>
                </telerik:RadWindow>
                <telerik:RadWindow ID="RadWindowForThrbtnDelete" runat="server" Modal="true" VisibleOnPageLoad="false"
                    Height="150px" Width="350px" BackColor="#DADADA" VisibleStatusbar="false" Behaviors="Close"
                    OnClientClose="CancelPopUpCMRTMRDeleteRedirect" Title="">
                    <ContentTemplate>
                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td style="padding-top: 20px; height: 2px" align="center">
                                    <span id="spnForThr" class="label" style="color: #767676" runat="server"></span>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-top: 10px" align="center">
                                    <asp:Button CssClass="AgadiaButton" ID="Button7" runat="server" Text="Home" Width="80px"
                                        OnClientClick="RedirectToHome();return false; " />
                                    &nbsp;
                                    <asp:Button CssClass="AgadiaButton" ID="Button9" runat="server" Text="Queue Manager"
                                        Width="100px" OnClientClick="RedirectToQueue();return false; " />&nbsp;
                                    <asp:Button CssClass="AgadiaButton" ID="Button10" runat="server" Text="Continue this Case"
                                        Width="100px" OnClientClick="CancelPopUpCMRTMRDeleteRedirect();return false;" />
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </telerik:RadWindow>
                
                <asp:Button ID="btnRefreshData" runat="server" Text="Finalize" ForeColor="White"
                    Style="display: none" OnClick="btnRefreshData_Click" />
                <telerik:RadWindow ID="rwPreCMR" runat="server" Modal="true" VisibleOnPageLoad="false"
                    Height="150px" Width="400px" BackColor="#DADADA" VisibleStatusbar="false" Behaviors="None"
                    Title="MTM" OnClientBeforeShow="fixIE10">
                    <ContentTemplate>
                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td style="padding-top: 20px; height: 2px" align="center">
                                    <span id="msgPreCMR" class="label" style="color: #767676; font-size: 12px" runat="server">
                                        Name:</span>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-top: 10px" align="center">
                                    <asp:Button ID="btnContinue" runat="server" OnClientClick="btnContinue_Click();return false;"
                                        Text="OK" CssClass="AgadiaButton"></asp:Button>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </telerik:RadWindow>
                <telerik:RadAjaxLoadingPanel ID="raLoadingPanel" runat="server">
                </telerik:RadAjaxLoadingPanel>
            </td>
        </tr>
    </table>
    <table width="100%">
        <tr class="blueBarHeader">
            <td style="width: 100%;">
                <span class="rpText">TMR Summary</span>
            </td>
        </tr>
        <tr>
            <td>
                <telerik:RadAjaxPanel ID="RadAjaxPanelTmr" runat="server" EnableAJAX="false" ClientEvents-OnRequestStart="onAjaxRequestStart"
                    LoadingPanelID="RadAjaxLoadingPanel1">
                    <telerik:RadGrid ID="TMRGrid" runat="server" AllowPaging="false" AllowSorting="false"
                        OnNeedDataSource="TMRGrid_NeedDataSource" AllowFilteringByColumn="False" Skin="Metro"
                        OnItemDataBound="TMRGrid_ItemDataBound" AutoGenerateColumns="false" CellSpacing="0"
                        GridLines="None" Width="100%" CellPadding="0" EnableViewState="true" OnItemCommand="TMRGrid_ItemCommand">
                        <MasterTableView DataKeyNames="DrugReviewSummaryId" CommandItemDisplay="Top" CommandItemSettings-ShowRefreshButton="false"
                            EnableViewState="true">
                            <CommandItemTemplate>
                                <div style="padding: 5px 5px;">
                                    <asp:LinkButton ID="btnAddNewTMR" Style="border: 1px solid #3DB8FA !important; background-color: #3DB8FA;
                                        color: White; text-align: center; line-height: 25px" runat="server" Text="+ Add New TMR"
                                        Width="105px" Height="25px" Enabled="True" OnClientClick="scrollBrowserTop()"
                                        OnClick="btnAddNewTMR_click"></asp:LinkButton>
                                </div>
                            </CommandItemTemplate>
                            <ExpandCollapseColumn Visible="false">
                            </ExpandCollapseColumn>
                            <NoRecordsTemplate>
                                <table border="0" cellpadding="0" cellspacing="0" style="border-width: 1px; border-color: ActiveBorder;
                                    border-style: solid;" width="100%">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblNoRecords" runat="server" Text="No records " CssClass="frmlabelnew"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </NoRecordsTemplate>
                            <Columns>
                                <telerik:GridBoundColumn DataField="ReviewName" FilterControlAltText="Filter Review Name column"
                                    HeaderText="Review Description" UniqueName="ReviewName" Visible="true">
                                    <HeaderStyle Width="10%" />
                                </telerik:GridBoundColumn>
                                <%-- <telerik:GridBoundColumn DataField="EndedByUser" FilterControlAltText="Filter Reviewed By column"
                                HeaderText="Reviewed By" UniqueName="EndedByUser">
                                <HeaderStyle Width="20%" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="EndDate" FilterControlAltText="Filter Reviewed Date column"
                                HeaderText="Reviewed Date" UniqueName="EndDate">
                                <HeaderStyle Width="20%" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Status" FilterControlAltText="Filter Status column"
                                HeaderText="Status" UniqueName="Status">
                                <HeaderStyle Width="10%" />
                            </telerik:GridBoundColumn>--%>
                                <telerik:GridBoundColumn DataField="EndedByUser" FilterControlAltText="Filter Reviewed By column"
                                    HeaderText="TMR Completed By" UniqueName="EndedByUser">
                                    <HeaderStyle Width="7%" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="TMRDate" FilterControlAltText="Filter Reviewed TMR Date column"
                                    HeaderText="TMR Date" UniqueName="TMRDate">
                                    <HeaderStyle Width="6%" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="TMRProgram" FilterControlAltText="Filter TMR Program column"
                                    HeaderText="TMR Program" UniqueName="TMRProgram">
                                    <HeaderStyle Width="28%" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="TMRType" FilterControlAltText="Filter TMR Type column"
                                    HeaderText="TMR Type" UniqueName="TMRType">
                                    <HeaderStyle Width="7%" />
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn DataField="Status" FilterControlAltText="Filter Status column"
                                    HeaderText="Status" UniqueName="Status">
                                    <HeaderStyle Width="8%" />
                                    <ItemTemplate>
                                        <asp:Label ID="StatusTmr" runat="server" Text='<%# Eval("Status").ToString()%>'></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn DataField="InterventionIdentified" FilterControlAltText="Filter Intervention Identified column"
                                    HeaderText="Intervention Identified" UniqueName="InterventionIdentified">
                                    <HeaderStyle Width="5%" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="InterventionDate" FilterControlAltText="Filter Intervention Date column"
                                    HeaderText="Intervention Date" UniqueName="InterventionDate">
                                    <HeaderStyle Width="10%" />
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn AllowFiltering="False" Visible="false">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkEditTemplate" runat="server" Text="Edit TMR Letter" ForeColor="Blue"
                                            CommandName="EditTemplate" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"DrugReviewSummaryId") %>'></asp:LinkButton>
                                    </ItemTemplate>
                                    <HeaderStyle Width="25px" />
                                    <ItemStyle Width="25px" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn AllowFiltering="False" Visible="false">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnlPreviewTemplate" runat="server" Text="Preview TMR Letter"
                                            ForeColor="Blue" CommandName="PreviewTemplate" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"DrugReviewSummaryId") %>'></asp:LinkButton>
                                    </ItemTemplate>
                                    <HeaderStyle Width="25px" />
                                    <ItemStyle Width="25px" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn Visible="false">
                                    <ItemTemplate>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn AllowFiltering="False" UniqueName="EditTMR" Groupable="False">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnlEditTMR" runat="server" Text='<%# ((Eval("Status").ToString() == "Completed") ? "View/Reopen TMR" : "Edit TMR") %>'
                                            ForeColor="Blue" CommandName="EditLink" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"DrugReviewSummaryId") %>'
                                            Enabled='<%#(  Eval("IsEnable").ToString()=="1") %>'></asp:LinkButton>
                                    </ItemTemplate>
                                    <HeaderStyle Width="30px" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn AllowFiltering="False" UniqueName="DeleteTMR" Groupable="False">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnlDeleteTMR" runat="server" Text='<%# ((Eval("Status").ToString() == "Completed") ? "" : "Delete TMR") %>'
                                            ForeColor="Blue" CommandName="DeleteLink" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"DrugReviewSummaryId") %>'></asp:LinkButton>
                                    </ItemTemplate>
                                    <HeaderStyle Width="40px" />
                                </telerik:GridTemplateColumn>
                            </Columns>
                            <HeaderStyle BackColor="#3DB8FA" BorderColor="#3DB8FA" ForeColor="White" />
                        </MasterTableView>
                        <FilterMenu EnableImageSprites="False">
                        </FilterMenu>
                    </telerik:RadGrid>
                </telerik:RadAjaxPanel>
            </td>
        </tr>
    </table>
    <table width="100%">
        <tr class="blueBarHeader">
            <td style="width: 100%;">
                <span class="rpText">CMR Summary</span>
            </td>
        </tr>
        <tr>
            <td>
                <telerik:RadAjaxPanel ID="RadAjaxPanelCmr" EnableAJAX="false" ClientEvents-OnRequestStart="onAjaxRequestStart"
                    runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                    <telerik:RadGrid ID="CMRGrid" runat="server" AllowPaging="false" AllowSorting="false"
                        OnItemDataBound="CMRGrid_ItemDataBound" OnNeedDataSource="CMRGrid_NeedDataSource"
                        AllowFilteringByColumn="False" Skin="Metro" AutoGenerateColumns="false" CellSpacing="0"
                        GridLines="None" Width="100%" CellPadding="0" ViewStateMode="Enabled" OnItemCommand="CMRGrid_ItemCommand">
                        <MasterTableView DataKeyNames="DrugReviewSummaryId,Status" CommandItemDisplay="Top"
                            AllowAutomaticInserts="false">
                            <CommandItemTemplate>
                                <div style="padding: 5px 5px;">
                                    <asp:LinkButton ID="btnAddNewCMR" Style="border: 1px solid #3DB8FA !important; background-color: #3DB8FA;
                                        color: White; text-align: center; line-height: 25px" runat="server" Text="+ Add New CMR"
                                        Width="105px" Height="25px" Enabled="True" OnClick="btnAddNewCMR_click"></asp:LinkButton>
                                </div>
                            </CommandItemTemplate>
                            <ExpandCollapseColumn Visible="false">
                            </ExpandCollapseColumn>
                            <NoRecordsTemplate>
                                <table border="0" cellpadding="0" cellspacing="0" style="border-width: 1px; border-color: ActiveBorder;
                                    border-style: solid;" width="100%">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblNoRecords" runat="server" Text="No records " CssClass="frmlabelnew"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </NoRecordsTemplate>
                            <Columns>
                                <telerik:GridBoundColumn DataField="ReviewName" FilterControlAltText="Filter Review Name column"
                                    HeaderText="Review Description" UniqueName="ReviewName" Visible="true">
                                    <HeaderStyle Width="25%" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="EndedByUser" FilterControlAltText="Filter Reviewed By column"
                                    HeaderText="Last Modified By" UniqueName="EndedByUser">
                                    <HeaderStyle Width="15%" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="EndDate" FilterControlAltText="Filter Reviewed Date column"
                                    HeaderText="Last Modified Date" UniqueName="EndDate">
                                    <HeaderStyle Width="15%" />
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn DataField="Status" FilterControlAltText="Filter Status column"
                                    HeaderText="Status" UniqueName="Status">
                                    <HeaderStyle Width="10%" />
                                    <ItemTemplate>
                                        <asp:Label ID="StatusCmr" runat="server" Text='<%# Eval("Status").ToString()%>'></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn AllowFiltering="False" Visible="false">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkEditTemplate" runat="server" Text="Edit CMR Letter" ForeColor="Blue"
                                            CommandName="EditTemplate" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"DrugReviewSummaryId") %>'></asp:LinkButton>
                                    </ItemTemplate>
                                    <HeaderStyle Width="25px" />
                                    <ItemStyle Width="25px" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn AllowFiltering="False" Visible="false">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnlPreviewTemplate" runat="server" Text="Preview CMR Letter"
                                            ForeColor="Blue" CommandName="PreviewTemplate" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"DrugReviewSummaryId") %>'></asp:LinkButton>
                                        <%--<a href="javascript:void(0);" onclick="PreviewTemplateInNewWindow()" style='color:Blue'>Preview CMR Letter</a>--%>
                                    </ItemTemplate>
                                    <HeaderStyle Width="25px" />
                                    <ItemStyle Width="25px" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn Visible="false">
                                    <ItemTemplate>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn AllowFiltering="False" UniqueName="EditCMR" Groupable="False">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnlEditCMR" runat="server" Text='<%# ((Eval("Status").ToString() == "Completed") ? "View/Reopen CMR" : "Edit CMR") %>'
                                            ForeColor="Blue" CommandName="EditLink" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"DrugReviewSummaryId") %>'></asp:LinkButton>
                                    </ItemTemplate>
                                    <HeaderStyle Width="25px" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn AllowFiltering="False" UniqueName="DeleteCMR" Groupable="False">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnlDeleteCMR" runat="server" Text='<%# ((Eval("Status").ToString() != "Completed") ? "Delete CMR" : "") %>'
                                            ForeColor="Blue" CommandName="DeleteLink" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"DrugReviewSummaryId") %>'></asp:LinkButton>
                                    </ItemTemplate>
                                    <HeaderStyle Width="40px" />
                                </telerik:GridTemplateColumn>
                            </Columns>
                            <HeaderStyle BackColor="#3DB8FA" BorderColor="#3DB8FA" ForeColor="White" />
                        </MasterTableView>
                        <ClientSettings>
                            <%--<ClientEvents   OnCommand="lnlEditCMR_ClientClick"/>--%>
                        </ClientSettings>
                        <FilterMenu EnableImageSprites="False">
                        </FilterMenu>
                    </telerik:RadGrid>
                </telerik:RadAjaxPanel>
            </td>
        </tr>
        <tr>
            <td>
                <img src="../CSS/AgadiaBlue/Images/spacer.gif" alt="" height="10px" />
            </td>
        </tr>
    </table>
    <asp:HiddenField ID="hdnFormat" runat="server" Value="" />
    <asp:HiddenField ID="hdnTimeZone" runat="server" Value="" />
    <asp:HiddenField ID="hdnFormatFollowUp" runat="server" Value="" />
    <asp:HiddenField ID="hdnTimeZoneFollowUp" runat="server" Value="EST" />
    <asp:HiddenField ID="hdnAppRepFirstName" runat="server" Value="" />
    <asp:HiddenField ID="hdnAppRepLastName" runat="server" Value="" />
</div>
<%--</telerik:RadAjaxPanel>--%>
<telerik:RadCodeBlock ID="RadCodeBlock2" runat="server">
    <script type="text/javascript">

        function alertrefreshCMR() {
            $find("<%=RadAjaxPanelCmr.ClientID %>").ajaxRequest();
        }
        function alertrefreshTMR() {
            $find("<%=RadAjaxPanelTmr.ClientID %>").ajaxRequest();
        }

        function OnRequestStartDelete(sender, eventArgs) {

        }

        function OnResponseEndDelete(sender, eventArgs) {

        }
        function Close() {
            var oWnd = $find("<%= raddeleteForCMRTMR.ClientID %>");
            oWnd.Close();
        }
        
    </script>
</telerik:RadCodeBlock>
