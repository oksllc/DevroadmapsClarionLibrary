!---------------------------------------------------------------------------------------------!
! Copyright (c) 2013, CoveComm Inc.
! All rights reserved.
!---------------------------------------------------------------------------------------------!
!region
!
! Redistribution and use in source and binary forms, with or without
! modification, are permitted provided that the following conditions are met:
!
! 1. Redistributions of source code must retain the above copyright notice, this
!    list of conditions and the following disclaimer.
! 2. Redistributions in binary form must reproduce the above copyright notice,
!    this list of conditions and the following disclaimer in the documentation
!    and/or other materials provided with the distribution.
! 3. The use of this software in a paid-for programming toolkit (that is, a commercial
!    product that is intended to assist in the process of writing software) is
!    not permitted.
!
! THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
! ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
! WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
! DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
! ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
! (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
! LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
! ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
! (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
! SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
!
! The views and conclusions contained in the software and documentation are those
! of the authors and should not be interpreted as representing official policies,
! either expressed or implied, of www.DevRoadmaps.com or www.ClarionMag.com.
!
! If you find this software useful, please support its creation and maintenance
! by taking out a subscription to www.DevRoadmaps.com.
!---------------------------------------------------------------------------------------------!
!endregion

                                            Member
                                            Map
                                            End

    include('CIDC_Sales_TaxCodes.inc'),once
    include('DCL_System_Diagnostics_Logger.inc'),once

dbg                                         DCL_System_Diagnostics_Logger

CIDC_Sales_TaxCodes.Construct               Procedure()
    code
    self.TaxCodeQ &= new CIDC_Sales_TaxCodes_TaxCodeQueue

CIDC_Sales_TaxCodes.Destruct                Procedure()
    code
    free(self.TaxCodeQ)
    dispose(self.TaxCodeQ)
    
CIDC_Sales_TaxCodes.AddCode                 procedure(string taxCode)
    code
    clear(self.TaxCodeQ)
    self.TaxCodeQ.TaxCode = taxCode
    add(self.TaxCodeQ)
    
CIDC_Sales_TaxCodes.AddToTaxableAmount      procedure(string taxCode,real amount)
    code
    if not self.FindCode(taxCode) then self.AddCode(taxCode).
    self.TaxCodeQ.TaxableTotal += amount
    put(self.TaxCodeQ)
    
CIDC_Sales_TaxCodes.FindCode                procedure(string taxCode)!,bool
    code
    self.TaxCodeQ.TaxCode = taxCode
    get(self.TaxCodeQ,self.TaxCodeQ.TaxCode)
    if not errorcode() then return true.
    return false

CIDC_Sales_TaxCodes.GetCode                 procedure(long index)!,string
    code
    if index > records(self.TaxCodeQ) then return ''.
    get(self.TaxCodeQ,index)
    return self.TaxCodeQ.TaxCode

CIDC_Sales_TaxCodes.GetCount                procedure!,long
    code
    return records(self.TaxCodeQ)
    
CIDC_Sales_TaxCodes.GetTax                  procedure(string taxCode)!,real
    code
    if self.FindCode(taxCode)
        return self.TaxCodeQ.Tax
    end
    return 0
CIDC_Sales_TaxCodes.GetTaxableTotal         procedure(string taxCode)!,real
    code
    if self.FindCode(taxCode)
        return self.TaxCodeQ.TaxableTotal
    end
    return 0
    
CIDC_Sales_TaxCodes.RemoveCode              procedure(string taxCode)
    code
    if self.FindCode(taxCode)
        delete(self.TaxCodeQ)
    end
    
CIDC_Sales_TaxCodes.Reset                   procedure
    code
    free(self.TaxCodeQ)
    
