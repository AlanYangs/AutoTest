/* Formatted on 17-Mar-2015 15:22:15 (QP5 v5.276) */
SELECT a.workitemid,
       a.workitemname,
       CASE a.currentstate
           WHEN 'HELP_WAITFIRM' THEN '待确认' --sdssdsdsd
           WHEN 'AGREE' THEN '确认'
           WHEN 'DISAGREE' THEN '驳回'
           WHEN 'REJECTED' THEN '拒绝'
           WHEN 'STOP' THEN '结束'
       END
           AS currentstate,
       a.starttime,
       a.processdefname
  FROM wf_workitem a
 WHERE        a.processinstid =
                  (SELECT processinstid
                     FROM wf_processinst
                    WHERE     processinstid =
                                  'C724DF87B0DD49869F3F8E3D266D7206'
                          AND currentstate <> 'SUSPENDED')
          AND a.currentstate <> 'DELETE'
          AND a.workitemid IN
                  (SELECT workitemid
                     FROM wf_wiparticipant
                    WHERE    (    particitype = 'USER'
                              AND participant =
                                      '09082AD58E8740A6B8574B8BD56C4611')
                          OR (    particitype = 'ROLE'
                              AND participant IN
                                      (SELECT role_id
                                         FROM cm_rluser
                                        WHERE user_id =
                                                  '09082AD58E8740A6B8574B8BD56C4611'))
                   UNION
                   SELECT workitemid
                     FROM wf_assistantitem
                    WHERE assistant = '09082AD58E8740A6B8574B8BD56C4611')
       OR a.workitemid IN
              (SELECT w.workitemid
                 FROM wf_workitem w
                WHERE     (   w.workitemid IN
                                  (SELECT workitemid
                                     FROM wf_wiparticipant
                                    WHERE (       particitype = 'USER'
                                              AND participant IN ('')
                                           OR (    particitype = 'ROLE'
                                               AND participant IN
                                                       (SELECT role_id
                                                          FROM cm_rluser
                                                         WHERE user_id IN
                                                                   ('')))))
                           OR w.workitemid IN (SELECT workitemid
                                                 FROM wf_assistantitem
                                                WHERE assistant IN ('')))
                      AND (w.activitydefid IN ('') OR w.processdefid IN ('')))
ORDER BY a.starttime