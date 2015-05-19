Set objExcel = CreateObject("Excel.Application") 
objExcel.Visible = True     
	set objworkbookdefault = objExcel.Workbooks.Open("C:\Users\Cody\Documents\2015\Q2\pet\python\upsell.xls") 

intRow = 2
extra_contact_name_start = 7
extra_contact_position_start = 8
extra_contact_number_start = 9

Do Until objExcel.Cells(intRow,2).Value = ""
	 if objExcel.Cells(intRow,2).value = objExcel.Cells(intRow + 1,2).value then
		extra_contact_name_destination = 11
		extra_contact_position_destination = 12
		extra_contact_number_destination = 13
		lskin_master_row = intRow

		 	Do Until objExcel.Cells(intRow,2).value <> objExcel.Cells(intRow + 1,2).value

				objExcel.Cells(lskin_master_row,extra_contact_name_destination).Value = objExcel.Cells(intRow+1,extra_contact_name_start)
				objExcel.Cells(lskin_master_row,extra_contact_position_destination).Value = objExcel.Cells(intRow+1,extra_contact_position_start)
				objExcel.Cells(lskin_master_row,extra_contact_number_destination).Value = objExcel.Cells(intRow+1,extra_contact_number_start)

				objExcel.Cells(intRow+1,extra_contact_name_start).Value = ""
				objExcel.Cells(intRow+1,extra_contact_position_start).Value = ""
				objExcel.Cells(intRow+1,extra_contact_number_start).Value = ""

				extra_contact_name_destination = extra_contact_name_destination + 4
				extra_contact_position_destination = extra_contact_position_destination + 4
				extra_contact_number_destination = extra_contact_number_destination + 4

	     		intRow = intRow + 1	 
		 	Loop

	 end if     
     intRow = intRow + 1
Loop	


intRow = 2

Do Until objExcel.Cells(intRow,2).Value = ""
	if objExcel.Cells(intRow,2).value = objExcel.Cells(intRow + 1,2).value then
		Set objRange = objExcel.Cells(intRow + 1, 1).EntireRow
		objRange.Delete
		intRow = intRow - 1	
	end if

	intRow = intRow + 1	 
Loop	

