Attribute VB_Name = "Easy_Solved"
Sub stock_checker()
' EASY SOLUTION. WORKS!

'Find the last row
Dim last_row As Double
last_row = Cells(Rows.Count, 1).End(xlUp).row

' Column of input data (volume).
Dim vol_col As Integer
vol_col = 7

' Initiate empty starting value
Dim counter As Double
counter = 0

' Set location to print output.
Dim sum_row As Integer
sum_row = 2

' Print table headers
Cells(1, 9) = "Ticker"
Cells(1, 10) = "Ticker Volume Total"

For i = 2 To last_row

    If Cells(i, 1).Value <> Cells(i + 1, 1).Value Then

    counter = counter + Cells(i, vol_col).Value
    Cells(sum_row, 10).Value = counter
    Cells(sum_row, 9).Value = Cells(i, 1).Value
    
    counter = 0
    sum_row = sum_row + 1
    
    Else
    counter = counter + Cells(i, vol_col).Value
    
    End If
    
Next i

End Sub
