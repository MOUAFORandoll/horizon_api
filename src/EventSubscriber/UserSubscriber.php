<?php

namespace App\EventSubscriber;

use ApiPlatform\Core\EventListener\EventPriorities;
use App\Entity\TypeUser;
use App\Entity\UserPlateform;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpKernel\Event\ViewEvent;
use Symfony\Component\HttpKernel\KernelEvents;
use App\FunctionU\MyFunction;

final class UserSubscriber extends AbstractController implements EventSubscriberInterface
{

    private $em;
    public    $doctrine;
    private $myFunction;

    public function __construct(
        EntityManagerInterface $em,
        MyFunction  $myFunction

    ) {
        $this->em = $em;
        $this->myFunction = $myFunction;
    }

    public static function getSubscribedEvents()
    {
        return [
            KernelEvents::VIEW => ['operationAfterCreateAMember', EventPriorities::POST_WRITE]
        ];
    }

    public function operationAfterCreateAMember(ViewEvent $event): void
    {
        $User = $event->getControllerResult();
        $method = $event->getRequest()->getMethod();
        if ($User instanceof UserPlateform && Request::METHOD_POST === $method) {
            $otherNumber = [];

            for ($i = 0; $i < 4; $i++) {
                try {
                    $otherNumber[] = random_int(0, 9);
                } catch (\Exception $e) {
                    echo $e;
                }
            }

            $keySecret = password_hash(($User->getPhone() . '' . $User->getPassword() . '' . (new \DateTime())->format('Y-m-d H:i:s') . '' . implode("", $otherNumber)), PASSWORD_DEFAULT);

            if (strlen($keySecret) > 100) {
                $keySecret = substr($keySecret, 0, 99);
            }

            $User->setKeySecret($keySecret);
            $this->em->persist($User);
            $this->em->flush();
        }
    }
}
