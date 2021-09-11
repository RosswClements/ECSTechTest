$MedalResults = @(
    @{
        'sport' = 'cycling'
        'podium' = @('1.China', '2.Germany', '3.ROC')
    }
    @{
        'sport' = 'fencing'
        'podium' = @('1.ROC', '2.France', '3.Italy')
    }
    @{
        'sport' = 'high jump'
        'podium' = @('1.Italy', '1.Qatar', '3.Belarus')
    }
    @{
        'sport' = 'swimming'
        'podium' = @('1.USA', '2.France', '3.Brazil')
    }
)

function Build-MedalTable {
    param
    (
        [Parameter(Mandatory)]
        [array]
        $Medals
    )

    # Add your code here
    # Create a medal table based on the provided result list
    # First place gives 3 points, second place 2 points and third place 1 point

    #Split string on . into key value pairs

    For($i = 0 ; $i -lt $Medals.length; $i++) {
        For($ii = 0 ; $ii -lt $Medals[$i]['podium'].length; $ii++) {
            Write-output $Medals[$i]['podium'][$ii]
            write-output ''
            
        }
    }
    
    write-output $Medals
    #Turn value (country) into key of new table

    #Change medal positions into scores and assign to values of new table
}


Build-MedalTable $MedalResults