global class Kodiak_PlayerFilePicklist extends VisualEditor.DynamicPickList{
    
    global override VisualEditor.DataRow getDefaultValue(){
        VisualEditor.DataRow defaultValue = new VisualEditor.DataRow('-- None --', null);
        return defaultValue;
    }
    global override VisualEditor.DynamicPickListRows getValues() {
        VisualEditor.DynamicPickListRows myValues = new VisualEditor.DynamicPickListRows();
        //PublishStatus = 'P' AND // Maybe needed
        List<ContentDocument> files = [SELECT Id, FileExtension, Title, PublishStatus FROM ContentDocument WHERE FileExtension IN ('webm','mp4')];
        for(ContentDocument f: files) {
            myValues.addRow(new VisualEditor.DataRow(String.valueOf(f.Title), String.valueOf(f.Id)));
        }
        return myValues;
    }
}