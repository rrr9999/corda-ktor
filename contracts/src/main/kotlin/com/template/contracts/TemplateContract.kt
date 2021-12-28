package com.template.contracts

import com.template.states.TemplateState
import net.corda.core.contracts.CommandData
import net.corda.core.contracts.Contract
import net.corda.core.contracts.requireSingleCommand
import net.corda.core.transactions.LedgerTransaction
import net.corda.core.contracts.requireThat

class TemplateContract : Contract {
    companion object {
        // Used to identify our contract when building a transaction.
        const val ID = "com.template.contracts.TemplateContract"
    }

    override fun verify(tx: LedgerTransaction) {
        // Verification logic goes here.
        val command = tx.commands.requireSingleCommand<Commands.Create>()
        val output = tx.outputsOfType<TemplateState>().first()
        when (command.value) {
            is Commands.Create -> requireThat {
                "No inputs should be consumed when sending the Hello-World message.".using(tx.inputStates.isEmpty())
                "The message must be Hello-World".using(output.msg == "Hello-World")
            }
        }
    }

    interface Commands : CommandData {
        class Create : Commands
    }
}
