trigger OrderTrigger on Order (before insert, before update, after insert, after update, before delete, after delete, after undelete) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            OrderTriggerHandler.onBeforeInsert(Trigger.new);
        }
        if(Trigger.isUpdate){
            OrderTriggerHandler.onBeforeUpdate(Trigger.new, Trigger.oldMap);
        }
        if(Trigger.isDelete){
            OrderTriggerHandler.onBeforeDelete(Trigger.old);
        }
    }
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            OrderTriggerHandler.onAfterInsert(Trigger.new);
        }
        if(Trigger.isUpdate){
            OrderTriggerHandler.onAfterUpdate(Trigger.new, Trigger.oldMap);
        }
        if(Trigger.isDelete){
            OrderTriggerHandler.onAfterDelete(Trigger.old);
        }
        if(Trigger.isUndelete){
            OrderTriggerHandler.onAfterUndelete(Trigger.new);
        }
    }
}