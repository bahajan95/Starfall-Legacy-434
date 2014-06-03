/*
* This program is free software; you can redistribute it and/or modify it
* under the terms of the GNU General Public License as published by the
* Free Software Foundation; either version 3 of the License, or (at your
* option) any later version.
*
* This program is distributed in the hope that it will be useful, but WITHOUT
* ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
* FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
* more details.
*
* You should have received a copy of the GNU General Public License along
* with this program. If not, see <http://www.gnu.org/licenses/>.
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "ScriptedEscortAI.h"
#include "Player.h"
#include "Vehicle.h"
#include "Creature.h"
#include "PetAI.h"
#include "PassiveAI.h"
#include "CombatAI.h"
#include "Pet.h"

class npc_geargrinder_gizmo_intro : public CreatureScript
{
public:
    npc_geargrinder_gizmo_intro() : CreatureScript("npc_geargrinder_gizmo_intro") {}

    enum questId
    {
        QUEST_ENTRY_GOBLIN_ESCAPE_PODS    = 14474
    };

    bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest)
    {
        if (quest->GetQuestId() == QUEST_ENTRY_GOBLIN_ESCAPE_PODS)
            creature->MonsterSay("Yeah, there's tons of people still trapped in the escape pods, boss. Oh, wait. I guess you're not the boss anymore. Anyways, they're all probably going to drown if you don't get them out.", 0, player->GetGUID());
        return false;
    }

    struct npc_geargrinder_gizmo_introAI : public ScriptedAI
    {
        EventMap events;

        npc_geargrinder_gizmo_introAI(Creature* creature) : ScriptedAI(creature)
        {
            eventInProgress = false;
            playerSummoner = NULL;
        }

        enum npcId
        {
            NPC_ENTRY_GEARGRINDER_GIZMO     = 36600,
            NPC_ENTRY_DOC_ZAPNOZZLE         = 36608
        };

        enum questId
        {
            QUEST_ENTRY_GOBLIN_ESCAPE_PODS   = 14474
        };

        enum eventId
        {
            EVENT_CHECK_PLAYER_CINEMATIC    = 1,
            EVENT_CHECK_SUMMONER
        };

        enum actionId
        {
            ACTION_START_PRE_EVENT  = 1,
            ACTION_TALK_0
        };

        enum spellId
        {
            SPELL_UNIQUE_PHASING    = 60191
        };

        void PreparePlayerForEvent()
        {
            if (playerSummoner && playerSummoner != NULL)
            {
                if (playerSummoner->ToPlayer())
                {
                    if (!playerSummoner->ToPlayer()->hasQuest(QUEST_ENTRY_GOBLIN_ESCAPE_PODS))
                        playerSummoner->SummonCreature(NPC_ENTRY_DOC_ZAPNOZZLE, 555.20f, 3271.99f, -0.95f, 3.12f, TEMPSUMMON_TIMED_DESPAWN, 300000, const_cast<SummonPropertiesEntry*>(sSummonPropertiesStore.LookupEntry(64)));
                }
            }
        }

        void IsSummonedBy(Unit* summoner)
        {
            summoner->AddAura(SPELL_UNIQUE_PHASING, me);
            me->SetReactState(REACT_PASSIVE);
            me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_QUESTGIVER);
            playerSummoner = summoner;
            events.ScheduleEvent(EVENT_CHECK_PLAYER_CINEMATIC, 5000);
            me->SetPhaseMask(8192, true);
        }

        void DoAction(int32 action)
        {
            switch (action)
            {
                case ACTION_START_PRE_EVENT:
                {
                    events.CancelEvent(EVENT_CHECK_PLAYER_CINEMATIC);
                    if (playerSummoner && playerSummoner != NULL)
                        playerSummoner->SetPhaseMask(8192, true);
                    PreparePlayerForEvent();
                    eventInProgress = true;
                    events.ScheduleEvent(EVENT_CHECK_SUMMONER, 2000);
                    break;
                }
                case ACTION_TALK_0:
                {
                    if (playerSummoner && playerSummoner != NULL)
                        Talk(0, playerSummoner->GetGUID());
                    break;
                }
                default:
                    break;
            }
        }

        void UpdateAI(uint32 diff)
        {
            events.Update(diff);

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_CHECK_PLAYER_CINEMATIC:
                    {
                        if (eventInProgress == true || !playerSummoner)
                        {
                            events.ScheduleEvent(EVENT_CHECK_PLAYER_CINEMATIC, 5000);
                            return;
                        }

                        if (playerSummoner == NULL)
                            return;

                        if (!playerSummoner->ToPlayer())
                        {
                            events.ScheduleEvent(EVENT_CHECK_PLAYER_CINEMATIC, 5000);
                            return;
                        }

                        if (!(playerSummoner->ToPlayer()->GetExtraFlags() & PLAYER_EXTRA_WATCHING_MOVIE))
                            DoAction(ACTION_START_PRE_EVENT);
                        else
                            events.ScheduleEvent(EVENT_CHECK_PLAYER_CINEMATIC, 5000);
                        break;
                    }
                    case EVENT_CHECK_SUMMONER:
                    {
                        if (!playerSummoner || (playerSummoner && !playerSummoner->IsInWorld()))
                            me->DespawnOrUnsummon(1);
                        else
                            events.ScheduleEvent(EVENT_CHECK_SUMMONER, 2000);
                        break;
                    }
                    default:
                        break;
                }
            }
        }

    protected:
        bool eventInProgress;
        Unit* playerSummoner;
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_geargrinder_gizmo_introAI(creature);
    }
};

class npc_doc_zapnozzle_intro : public CreatureScript
{
public:
    npc_doc_zapnozzle_intro() : CreatureScript("npc_doc_zapnozzle_intro") {}

    enum questId
    {
        QUEST_DONT_GO_INTO_THE_LIGHT   = 14239
    };

    enum spellId
    {
        SPELL_DEFIBRILLATE      = 45872,
        SPELL_FEIGN_DEATH_1     = 58951,
        SPELL_FEIGN_DEATH_2     = 79153,
        SPELL_UNIQUE_PHASING    = 60191
    };

    bool OnQuestReward(Player* player, Creature* creature, Quest const* quest, uint32 opt)
    {
        switch (quest->GetQuestId())
        {
            case QUEST_DONT_GO_INTO_THE_LIGHT:
            {
                player->SetControlled(false, UNIT_STATE_ROOT);
                player->SetStandState(UNIT_STAND_STATE_STAND);
                player->RemoveAurasDueToSpell(SPELL_UNIQUE_PHASING);
                player->SetPhaseMask(2, true);
                break;
            }
            default:
                break;
        }
        return true;
    }

    struct npc_doc_zapnozzle_introAI : public ScriptedAI
    {
        EventMap events;

        npc_doc_zapnozzle_introAI(Creature* creature) : ScriptedAI(creature)
        {
            enableAI = false;
            playerSummoner = NULL;
        }

        enum npcId
        {
            NPC_ENTRY_GEARGRINDER_GIZMO     = 36600,
            NPC_ENTRY_DOC_ZAPNOZZLE         = 36608
        };

        enum actionId
        {
            ACTION_MOVE_TO_PLAYER   = 1,
            ACTION_ENABLE_AI
        };

        enum eventId
        {
            EVENT_START_TALK        = 1,
            EVENT_CHECK_SUMMONER
        };

        enum pointId
        {
            POINT_TO_PLAYER     = 1,
            POINT_AFTER_JUMP
        };

        class enableGizmo : public BasicEvent
        {
            public:
                explicit enableGizmo(Creature* creature) : creature(creature) {}

            bool Execute(uint64 /*currTime*/, uint32 /*diff*/)
            {
                if (Creature* gizmo = creature->FindNearestCreature(NPC_ENTRY_GEARGRINDER_GIZMO, 20.0f, true))
                    gizmo->AI()->DoAction(2);
                return true;
            }

        private:
            Creature* creature;
        };

        class enableQuestGiver : public BasicEvent
        {
            public:
                explicit enableQuestGiver(Creature* creature) : creature(creature) {}

            bool Execute(uint64 /*currTime*/, uint32 /*diff*/)
            {
                creature->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_QUESTGIVER);
                return true;
            }

        private:
            Creature* creature;
        };

        void IsSummonedBy(Unit* summoner)
        {
            summoner->AddAura(SPELL_UNIQUE_PHASING, me);
            me->SetReactState(REACT_PASSIVE);
            me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_QUESTGIVER);
            playerSummoner = summoner;
            me->SetPhaseMask(8192, true);
            DoAction(ACTION_MOVE_TO_PLAYER);
            eventCompleted = false;
            events.ScheduleEvent(EVENT_CHECK_SUMMONER, 2000);
        }

        void DoAction(int32 action)
        {
            switch (action)
            {
                case ACTION_MOVE_TO_PLAYER:
                {
                    me->GetMotionMaster()->MovePoint(POINT_TO_PLAYER, 539.42f, 3272.23f, -0.95f, true);
                    break;
                }
                case ACTION_ENABLE_AI:
                {
                    enableAI = true;
                    events.ScheduleEvent(EVENT_START_TALK, 1000);
                    break;
                }
                default:
                    break;
            }
        }

        void MovementInform(uint32 type, uint32 pointId)
        {
            if (type != POINT_MOTION_TYPE && type != EFFECT_MOTION_TYPE)
               return;

            switch (pointId)
            {
                case POINT_TO_PLAYER:
                {
                    me->GetMotionMaster()->MoveJump(537.44f, 3272.09f, 0.18f, 7.0f, 7.0f, POINT_AFTER_JUMP);
                    break;
                }
                case POINT_AFTER_JUMP:
                {
                    DoAction(ACTION_ENABLE_AI);
                    break;
                }
                default:
                    break;
            }
        }

        void UpdateAI(uint32 diff)
        {
            events.Update(diff);

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_START_TALK:
                    {
                        if (me->GetPhaseMask() != 8192)
                        {
                            events.CancelEvent(EVENT_START_TALK);
                            return;
                        }

                        if (playerSummoner && playerSummoner != NULL && eventCompleted == false)
                        {
                            TalkWithDelay(500, 0, playerSummoner->GetGUID());
                            TalkWithDelay(8000, 1, playerSummoner->GetGUID());
                            me->m_Events.AddEvent(new enableGizmo(me), (me)->m_Events.CalculateTime(15000));
                            TalkWithDelay(21000, 2, playerSummoner->GetGUID());
                            me->CastWithDelay(28000, playerSummoner, SPELL_DEFIBRILLATE);
                            TalkWithDelay(36000, 3, playerSummoner->GetGUID());
                            me->CastWithDelay(41000, playerSummoner, SPELL_DEFIBRILLATE);
                            TalkWithDelay(48000, 4, playerSummoner->GetGUID());
                            me->m_Events.AddEvent(new enableQuestGiver(me), (me)->m_Events.CalculateTime(54000));
                            events.CancelEvent(EVENT_START_TALK);
                            eventCompleted = true;
                        }
                        break;
                    }
                    case EVENT_CHECK_SUMMONER:
                    {
                        if (!playerSummoner || (playerSummoner && !playerSummoner->IsInWorld()))
                            me->DespawnOrUnsummon(1);
                        else
                            events.ScheduleEvent(EVENT_CHECK_SUMMONER, 2000);
                        break;
                    }
                    default:
                        break;
                }
            }
        }

    protected:
        bool enableAI;
        bool eventCompleted;
        Unit* playerSummoner;
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_doc_zapnozzle_introAI(creature);
    }
};

class go_goblin_escape_pod : public GameObjectScript
{
public:
    go_goblin_escape_pod() : GameObjectScript("go_goblin_escape_pod") { }

    enum questId
    {
        QUEST_ENTRY_GOBLIN_ESCAPE_PODS  = 14474
    };

    enum spellId
    {
        SPELL_GOBLIN_SURVIVOR_SUCCESS   = 66137,
        SPELL_GOBLIN_SURVIVOR_FAILED    = 66138
    };

    bool OnGossipHello(Player* player, GameObject* go)
    {
        if (player->GetQuestStatus(QUEST_ENTRY_GOBLIN_ESCAPE_PODS) == QUEST_STATUS_INCOMPLETE)
        {
            if (roll_chance_f(50))
                player->CastWithDelay(500, player, SPELL_GOBLIN_SURVIVOR_SUCCESS, true);
            else
                player->CastWithDelay(500, player, SPELL_GOBLIN_SURVIVOR_FAILED, true);
            return false;
        }
        return true;
    }
};

class npc_bomb_throwing_monkey : public CreatureScript
{
public:
    npc_bomb_throwing_monkey() : CreatureScript("npc_bomb_throwing_monkey") {}

    enum spellId
    {
        SPELL_DEFIBRILLATE      = 45872,
        SPELL_FEIGN_DEATH_1     = 58951,
        SPELL_FEIGN_DEATH_2     = 79153,
        SPELL_UNIQUE_PHASING    = 60191
    };

    struct npc_bomb_throwing_monkeyAI : public ScriptedAI
    {
        npc_bomb_throwing_monkeyAI(Creature* creature) : ScriptedAI(creature) { }

        EventMap events;

        enum actionId
        {
            ACTION_MOVE_JUMP_UP     = 1,
            ACTION_FALL_ON_GROUND,
            ACTION_DIE_ON_GROUND
        };

        enum pointId
        {
            POINT_TO_AIR        = 1,
            POINT_TO_GROUND
        };

        enum eventId
        {
            EVENT_CAST_MONKEY_BOMB  = 1,
            EVENT_MOVE_FALL,
            EVENT_DIE_AFTER_FALL
        };

        enum spellId
        {
            SPELL_MONKEY_BOMB               = 8858,
            SPELL_NITRO_POTASSIUM_BANANAS   = 67917,
            SPELL_EXPLODING_BANANAS         = 67919
        };

        enum questCredit
        {
            QUEST_CREDIT_MONKEY_BOMBED  = 35760
        };

        void SpellHit(Unit* caster, SpellInfo const* spell)
        {
            switch (spell->Id)
            {
                case SPELL_NITRO_POTASSIUM_BANANAS:
                {
                    DoCast(me, SPELL_EXPLODING_BANANAS);
                    if (caster && caster->GetTypeId() == TYPEID_PLAYER)
                        caster->ToPlayer()->KilledMonsterCredit(QUEST_CREDIT_MONKEY_BOMBED);
                    break;
                }
                case SPELL_EXPLODING_BANANAS:
                {
                    DoAction(ACTION_MOVE_JUMP_UP);
                    break;
                }
                default:
                    break;
            }
        }

        void EnterCombat(Unit* /*who*/)
        {
            events.ScheduleEvent(EVENT_CAST_MONKEY_BOMB, urand(3500, 5000));
        }

        void DoAction(int32 action)
        {
            switch (action)
            {
                case ACTION_MOVE_JUMP_UP:
                {
                    groundZ = me->GetPositionZ();
                    me->GetMotionMaster()->MovementExpired(false);
                    me->GetMotionMaster()->MoveJump(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()+75.0f, 25.0f, 25.0f, POINT_TO_AIR);
                    events.CancelEvent(EVENT_CAST_MONKEY_BOMB);
                    events.ScheduleEvent(EVENT_MOVE_FALL, 3500);
                    break;
                }
                case ACTION_FALL_ON_GROUND:
                {
                    me->GetMotionMaster()->MoveJump(me->GetPositionX(), me->GetPositionY(), groundZ, 25.0f, 25.0f, POINT_TO_GROUND);
                    events.ScheduleEvent(EVENT_DIE_AFTER_FALL, 3000);
                    break;
                }
                case ACTION_DIE_ON_GROUND:
                {
                    me->Kill(me, false);
                    break;
                }
                default:
                    break;
            }
        }

        void UpdateAI(uint32 diff)
        {
            events.Update(diff);

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_CAST_MONKEY_BOMB:
                    {
                        if (Unit* victim = me->getVictim())
                            DoCast(victim, SPELL_MONKEY_BOMB);
                        events.RescheduleEvent(EVENT_CAST_MONKEY_BOMB, urand(3500, 5000));
                        break;
                    }
                    case EVENT_MOVE_FALL:
                    {
                        DoAction(ACTION_FALL_ON_GROUND);
                        break;
                    }
                    case EVENT_DIE_AFTER_FALL:
                    {
                        DoAction(ACTION_DIE_ON_GROUND);
                        break;
                    }
                    default:
                        break;
                }
            }
        }

    protected:
        float groundZ;
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_bomb_throwing_monkeyAI(creature);
    }
};

void AddSC_the_lost_isles()
{
    new npc_geargrinder_gizmo_intro();
    new npc_doc_zapnozzle_intro();
    new go_goblin_escape_pod();
    new npc_bomb_throwing_monkey();
}
