﻿// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace Microsoft.FixedAssets.FixedAsset;

using Microsoft.Finance.GST.Base;

tableextension 18002 "GST Fixed Asset Ext" extends "Fixed Asset"
{
    fields
    {
        field(18000; "GST Group Code"; code[20])
        {
            Caption = 'GST Group Code';
            DataClassification = CustomerContent;
            TableRelation = "GST Group";
        }
        field(18001; "HSN/SAC Code"; code[10])
        {
            Caption = 'HSN/SAC Code';
            DataClassification = CustomerContent;
            TableRelation = "HSN/SAC".Code where("GST Group Code" = field("GST Group Code"));
        }
        field(18002; "GST Credit"; enum "GST Credit")
        {
            Caption = 'GST Credit';
            DataClassification = CustomerContent;
        }
        field(18003; Exempted; boolean)
        {
            Caption = 'Exempted';
            DataClassification = CustomerContent;
        }
    }
}
