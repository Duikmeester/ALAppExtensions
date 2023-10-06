namespace Microsoft.API.V1;

using Microsoft.Foundation.PaymentTerms;
using Microsoft.Integration.Graph;

page 20023 "APIV1 - Payment Terms"
{
    APIVersion = 'v1.0';
    Caption = 'paymentTerms', Locked = true;
    DelayedInsert = true;
    EntityName = 'paymentTerm';
    EntitySetName = 'paymentTerms';
    ODataKeyFields = SystemId;
    PageType = API;
    SourceTable = "Payment Terms";
    Extensible = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(id; Rec.SystemId)
                {
                    Caption = 'id', Locked = true;
                    Editable = false;
                }
                field("code"; Rec.Code)
                {
                    Caption = 'code', Locked = true;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(Rec.FieldNo(Code));
                    end;
                }
                field(displayName; Rec.Description)
                {
                    Caption = 'displayName', Locked = true;

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(Rec.FieldNo(Description));
                    end;
                }
                field(dueDateCalculation; Rec."Due Date Calculation")
                {
                    Caption = 'dueDateCalculation', Locked = true;

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(Rec.FieldNo("Due Date Calculation"));
                    end;
                }
                field(discountDateCalculation; Rec."Discount Date Calculation")
                {
                    Caption = 'discountDateCalculation', Locked = true;

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(Rec.FieldNo("Discount Date Calculation"));
                    end;
                }
                field(discountPercent; Rec."Discount %")
                {
                    Caption = 'discountPercent', Locked = true;

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(Rec.FieldNo("Discount %"));
                    end;
                }
                field(calculateDiscountOnCreditMemos; Rec."Calc. Pmt. Disc. on Cr. Memos")
                {
                    Caption = 'calcPmtDiscOnCreditMemos', Locked = true;

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(Rec.FieldNo("Calc. Pmt. Disc. on Cr. Memos"));
                    end;
                }
                field(lastModifiedDateTime; Rec."Last Modified Date Time")
                {
                    Caption = 'lastModifiedDateTime', Locked = true;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        PaymentTerms: Record "Payment Terms";
        GraphMgtGeneralTools: Codeunit "Graph Mgt - General Tools";
        RecordRef: RecordRef;
    begin
        PaymentTerms.SETRANGE(Code, Rec.Code);
        if not PaymentTerms.ISEMPTY() then
            Rec.insert();

        Rec.insert(true);

        RecordRef.GetTable(Rec);
        GraphMgtGeneralTools.ProcessNewRecordFromAPI(RecordRef, TempFieldSet, CURRENTDATETIME());
        RecordRef.SetTable(Rec);

        Rec.Modify(true);
        exit(false);
    end;

    trigger OnModifyRecord(): Boolean
    var
        PaymentTerms: Record "Payment Terms";
    begin
        PaymentTerms.GetBySystemId(Rec.SystemId);

        if Rec.Code = PaymentTerms.Code then
            Rec.Modify(true)
        else begin
            PaymentTerms.TransferFields(Rec, false);
            PaymentTerms.Rename(Rec.Code);
            Rec.TransferFields(PaymentTerms, true);
        end;
    end;

    var
        TempFieldSet: Record 2000000041 temporary;

    local procedure RegisterFieldSet(FieldNo: Integer)
    begin
        if TempFieldSet.GET(DATABASE::"Payment Terms", FieldNo) then
            exit;

        TempFieldSet.INIT();
        TempFieldSet.TableNo := DATABASE::"Payment Terms";
        TempFieldSet.Validate("No.", FieldNo);
        TempFieldSet.insert(true);
    end;
}







