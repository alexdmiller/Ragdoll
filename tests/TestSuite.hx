import massive.munit.TestSuite;

import apg.ragdoll.messages.EntitiesMessageTest;
import apg.ragdoll.utils.NapeUtilsTest;

/**
 * Auto generated Test Suite for MassiveUnit.
 * Refer to munit command line tool for more information (haxelib run munit)
 */

class TestSuite extends massive.munit.TestSuite
{		

	public function new()
	{
		super();

		add(apg.ragdoll.messages.EntitiesMessageTest);
		add(apg.ragdoll.utils.NapeUtilsTest);
	}
}
